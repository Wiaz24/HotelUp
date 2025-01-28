#! /bin/bash
CLUSTER_NAME="hotelup-cluster"

eksctl create cluster -f eksctl/$CLUSTER_NAME.yaml
eksctl utils write-kubeconfig --cluster=$CLUSTER_NAME

# Add kubernetes-dashboard
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard

bash eksctl/connect_to_cluster.sh

kubectl apply -f hotelup-ns.yaml