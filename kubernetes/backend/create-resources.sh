#!/bin/bash

NAMESPACE=$1
if [ -z "$1" ]; then
    NAMESPACE="hotelup"
fi
SCRIPT_DIR="$(dirname "$(realpath "$0")")"


PROJECT_DIR=$(realpath $SCRIPT_DIR/../..)

# Cleaning
kubectl apply -f "$PROJECT_DIR/HotelUp.Cleaning/k8s/hotelup-cleaning.yml"

# Customer
kubectl apply -f $PROJECT_DIR/HotelUp.Customer/k8s/hotelup-customer.yml

# Employee
kubectl apply -f $PROJECT_DIR/HotelUp.Employee/k8s/hotelup-employee.yml

# Frontend
bash $PROJECT_DIR/HotelUp.Frontend/k8s/create-secrets.sh
kubectl apply -f $PROJECT_DIR/HotelUp.Frontend/k8s/hotelup-frontend.yml

# Information
kubectl apply -f $PROJECT_DIR/HotelUp.Information/k8s/hotelup-information.yml

# Kitchen
kubectl apply -f $PROJECT_DIR/HotelUp.Kitchen/k8s/hotelup-kitchen.yml

# Repair
bash $PROJECT_DIR/HotelUp.Repair/k8s/create-secrets.sh
kubectl apply -f $PROJECT_DIR/HotelUp.Repair/k8s/hotelup-repair.yml