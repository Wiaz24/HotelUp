#!/bin/bash

NAMESPACE=$1
if [ -z "$1" ]; then
    NAMESPACE="hotelup"
fi
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

kubectl apply -f "$SCRIPT_DIR/cert-manager.yaml"

kubectl wait --for=condition=available deployment/cert-manager -n cert-manager
kubectl wait --for=condition=available deployment/cert-manager-cainjector -n cert-manager
kubectl wait --for=condition=available deployment/cert-manager-webhook -n cert-manager

kubectl apply -f "$SCRIPT_DIR/issuer.yaml" -n $NAMESPACE
kubectl apply -f "$SCRIPT_DIR/certificate.yaml" -n $NAMESPACE
kubectl apply -f "$SCRIPT_DIR/ingress.yaml" -n $NAMESPACE