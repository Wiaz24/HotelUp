#!/bin/bash

NAMESPACE=$1
if [ -z "$1" ]; then
    NAMESPACE="hotelup"
fi
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

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
        password: $(echo -n "`aws ssm get-parameter --name /HotelUp.Postgres/Production/password --with-decrypt --output text --profile wiaz --region us-east-1 --query Parameter.Value`" | base64 -w0)
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

kubectl apply -f $SCRIPT_DIR/postgres.yaml
kubectl apply -f $SCRIPT_DIR/pgadmin.yaml