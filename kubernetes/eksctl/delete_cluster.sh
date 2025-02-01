#! /bin/bash
CLUSTER_NAME="hotelup-cluster"

eksctl delete cluster --name=$CLUSTER_NAME