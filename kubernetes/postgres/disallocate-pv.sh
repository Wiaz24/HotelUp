#!/bin/bash

kubectl get pvc -n hotelup --no-headers | grep ^postgres-storage-postgres-statefulset | awk '{print $1}' | xargs kubectl delete pvc -n hotelup