#!/bin/bash

NAMESPACE=$1
if [ -z "$1" ]; then
    NAMESPACE="hotelup"
fi
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

kubectl delete -f $SCRIPT_DIR/rabbitmq-cluster.yaml -n $NAMESPACE
kubectl apply -f $SCRIPT_DIR/rabbitmq-secret.yaml  -n $NAMESPACE
kubectl delete -f "https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml"