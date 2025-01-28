#!/bin/bash
# Create a local cluster using minikube

minikube start --mount-string ${HOME}/.aws/credentials:/.aws/credentials --mount
# minikube addons enable ingress
minikube addons enable dashboard
kubectl port-forward service/kubernetes-dashboard -n kubernetes-dashboard 9000:80 &

kubectl apply -f hotelup-ns.yaml
bash rabbitmq/create-resources.sh
bash postgres/create-resources.sh

