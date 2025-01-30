#!/bin/bash

NAMESPACE=$1
if [ -z "$1" ]; then
    NAMESPACE="hotelup"
fi
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

# kubectl delete -f "$SCRIPT_DIR/cert-manager.yaml"
kubectl delete -f "$SCRIPT_DIR/issuer.yaml" -n $NAMESPACE
kubectl delete -f "$SCRIPT_DIR/certificate.yaml" -n $NAMESPACE
kubectl delete -f "$SCRIPT_DIR/ingress.yaml" -n $NAMESPACE