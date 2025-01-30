#!/bin/bash
# Create a local cluster using minikube

minikube start
minikube addons enable ingress
minikube addons enable dashboard

kubectl create ns hotelup
bash rabbitmq/create-resources.sh
bash postgres/create-resources.sh
bash backend/create-resources.sh
bash ingress/create-resources.sh

kubectl port-forward service/kubernetes-dashboard -n kubernetes-dashboard 9000:80 &
sudo minikube tunnel 