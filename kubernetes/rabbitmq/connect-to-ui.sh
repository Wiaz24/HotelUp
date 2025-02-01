#!/bin/bash
SERVICE_NAME="rabbitmq-cluster"

wslview http://localhost:15672 &
kubectl port-forward "service/$SERVICE_NAME" 15672 -n hotelup
