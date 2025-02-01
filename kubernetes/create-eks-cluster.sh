#! /bin/bash
CLUSTER_NAME="hotelup-cluster"

eksctl create cluster -f eksctl/$CLUSTER_NAME.yaml
eksctl utils write-kubeconfig --cluster=$CLUSTER_NAME

eksctl create iamserviceaccount \
  --cluster=$CLUSTER_NAME \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name LabRole \
  --attach-policy-arn=arn:aws:iam::aws:policy/AmazonEKSLoadBalancingPolicy \
  --approve

# Add kubernetes-dashboard
kubectl apply -f eksctl/eks-admin-service-account.yaml
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard

kubectl create ns hotelup
bash rabbitmq/create-resources.sh
bash postgres/create-resources.sh
bash backend/create-resources.sh