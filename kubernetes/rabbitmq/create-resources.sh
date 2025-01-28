#!/bin/bash

NAMESPACE=$1
if [ -z "$1" ]; then
    NAMESPACE="hotelup"
fi
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

kubectl apply -f "https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml"
kubectl apply -f $SCRIPT_DIR/rabbitmq-secret.yaml  -n $NAMESPACE
sleep 10
kubectl apply -f $SCRIPT_DIR/rabbitmq-cluster.yaml  -n $NAMESPACE