#!/bin/bash

NAMESPACE=$1
if [ -z "$1" ]; then
    NAMESPACE="default"
fi
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

kubectl apply -f $SCRIPT_DIR/postgres-secret.yaml
kubectl apply -f $SCRIPT_DIR/postgres.yaml

kubectl apply -f $SCRIPT_DIR/pgadmin-secret.yaml
kubectl apply -f $SCRIPT_DIR/pgadmin.yaml