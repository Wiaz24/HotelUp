#!/bin/bash

NAMESPACE=$1
if [ -z "$1" ]; then
    NAMESPACE="hotelup"
fi
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

kubectl delete -f $SCRIPT_DIR/postgres.yaml
kubectl delete secret postgres-secret -n $NAMESPACE

kubectl delete -f $SCRIPT_DIR/pgadmin.yaml
kubectl delete secret pgadmin-secret -n $NAMESPACE
kubectl delete configmap postgresql-conf-config -n $NAMESPACE
kubectl delete configmap init-sql-config -n $NAMESPACE