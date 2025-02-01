#!/bin/bash

NAMESPACE=$1
if [ -z "$1" ]; then
    NAMESPACE="hotelup"
fi
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

postgres_password=$(echo -n "`aws ssm get-parameter --name /HotelUp.Postgres/Production/password --with-decrypt --output text --profile wiaz --region us-east-1 --query Parameter.Value`")

cat << EOF | kubectl apply -f -
    apiVersion: v1
    kind: Secret
    metadata:
        name: postgres-secret
        namespace: ${NAMESPACE}
    type: Opaque
    data:
        database: $(echo -n "`aws ssm get-parameter --name /HotelUp.Postgres/Production/database --with-decrypt --output text --profile wiaz --region us-east-1 --query Parameter.Value`" | base64 -w0)
        user: $(echo -n "`aws ssm get-parameter --name /HotelUp.Postgres/Production/user --with-decrypt --output text --profile wiaz --region us-east-1 --query Parameter.Value`" | base64 -w0)
        password: $(echo -n $postgres_password | base64 -w0)
EOF

cat << EOF | kubectl apply -f -
    apiVersion: v1
    kind: Secret
    metadata:
        name: pgadmin-secret
        namespace: ${NAMESPACE}
    type: Opaque
    data:
        email: $(echo -n "`aws ssm get-parameter --name /HotelUp.Pgadmin/Production/email --with-decrypt --output text --profile wiaz --region us-east-1 --query Parameter.Value`" | base64 -w0)
        password: $(echo -n "`aws ssm get-parameter --name /HotelUp.Pgadmin/Production/password --with-decrypt --output text --profile wiaz --region us-east-1 --query Parameter.Value`" | base64 -w0)
EOF

cat << EOF | kubectl apply -f -
    apiVersion: v1
    kind: ConfigMap
    metadata:
        name: init-sql-config
        namespace: ${NAMESPACE}
    data:
        init.sql: |
            DO \$\$
            DECLARE
            service RECORD;
            BEGIN
            FOR service IN
            SELECT unnest(ARRAY['customer', 'cleaning', 'repair', 'kitchen', 'employee', 'payment', 'information']) AS name
                LOOP
                -- Create role
                EXECUTE format('CREATE ROLE %I_role;', service.name);

                -- Create schema with role as owner
                EXECUTE format('CREATE SCHEMA %I AUTHORIZATION %I_role;', service.name, service.name);
                
                -- Create user with password and grant role
                EXECUTE format('CREATE USER %I_user WITH PASSWORD ''%I_$postgres_password'';', service.name, service.name);
                EXECUTE format('GRANT %I_role TO %I_user;', service.name, service.name);
                
                -- Grant usage and all privileges on schema to role
                EXECUTE format('GRANT USAGE ON SCHEMA %I TO %I_role;', service.name, service.name);
                EXECUTE format('GRANT ALL PRIVILEGES ON SCHEMA %I TO %I_role;', service.name, service.name);
                
                -- Grant all privileges on tables to role and set search path
                EXECUTE format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT ALL PRIVILEGES ON TABLES TO %I_role;', service.name, service.name);
                EXECUTE format('ALTER ROLE %I_role SET search_path TO %I', service.name, service.name);
                END LOOP;
            END \$\$;

            -- Revoke all privileges on public schema
            REVOKE ALL ON SCHEMA public FROM PUBLIC;
            ALTER SYSTEM SET track_commit_timestamp = on;
EOF

kubectl create configmap postgresql-conf-config --from-file=$SCRIPT_DIR/postgresql.conf --namespace=$NAMESPACE

kubectl apply -f $SCRIPT_DIR/postgres.yaml
kubectl apply -f $SCRIPT_DIR/pgadmin.yaml