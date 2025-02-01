#! /bin/bash
CLUSTER_NAME="hotelup-cluster"

eksctl create cluster -f eksctl/$CLUSTER_NAME.yaml
eksctl utils write-kubeconfig --cluster=$CLUSTER_NAME

# Add nginx-ingress
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx --create-namespace
  
# Add kubernetes-dashboard
kubectl apply -f eksctl/eks-admin-service-account.yaml
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard

kubectl create ns hotelup
bash rabbitmq/create-resources.sh
bash postgres/create-resources.sh
bash backend/create-resources.sh