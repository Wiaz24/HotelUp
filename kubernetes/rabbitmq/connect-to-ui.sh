#!/bin/bash
SERVICE_NAME="rabbitmq-cluster"

username="$(kubectl get secret -n hotelup $SERVICE_NAME-default-user -o jsonpath='{.data.username}' | base64 --decode)"
echo "username: $username"
password="$(kubectl get secret $SERVICE_NAME-default-user -o jsonpath='{.data.password}' | base64 --decode)"
echo "password: $password"

wslview http://localhost:15672 &
kubectl port-forward "service/$SERVICE_NAME" 15672 
