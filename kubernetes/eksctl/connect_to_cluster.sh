#! /bin/bash
CLUSTER_NAME="hotelup-cluster"
DASHBOARD_PORT=2137
# read -p "Enter the cluster name: " CLUSTER_NAME
echo "Connecting to cluster $CLUSTER_NAME..."

eksctl utils write-kubeconfig --cluster=$CLUSTER_NAME
kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-kong-proxy $DASHBOARD_PORT:443 &

# Pobranie tokenu do logowania do dashboarda
KUBE_TOKEN=$(kubectl create token eks-admin -n kube-system)
if [[ -z "$KUBE_TOKEN" ]]; then
  echo "Nie udało się wygenerować tokena kubetoken."
  exit 1
fi
# echo "Submit this token in login url:"
GREEN='\033[0;32m'
BLUE='\033[1;34m'
echo -e "${GREEN}Submit this token in login url:"
echo -e "${BLUE}$KUBE_TOKEN"

DASHBOARD_BASE_URL="https://localhost:$DASHBOARD_PORT"

wslview $DASHBOARD_BASE_URL &