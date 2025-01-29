#!/bin/bash

NAMESPACE=$1
if [ -z "$1" ]; then
    NAMESPACE="hotelup"
fi
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

username=$(echo -n "`aws ssm get-parameter --name /HotelUp.Rabbitmq/Production/username --with-decrypt --output text --profile wiaz --region us-east-1 --query Parameter.Value`")
password=$(echo -n "`aws ssm get-parameter --name /HotelUp.Rabbitmq/Production/password --with-decrypt --output text --profile wiaz --region us-east-1 --query Parameter.Value`")

cat << EOF | kubectl apply -f -
    apiVersion: v1
    kind: Secret
    metadata:
        name: rabbitmq-secret
        namespace: $NAMESPACE
    type: Opaque
    stringData:
        default_user.conf: |
            default_user = $username
            default_pass = $password
        host: rabbitmq-cluster.hotelup.svc
        username: $username
        password: $password
        port: "5672"
        provider: rabbitmq
        type: rabbitmq
EOF

kubectl apply -f "https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml"
sleep 10
kubectl apply -f $SCRIPT_DIR/rabbitmq-cluster.yaml  -n $NAMESPACE