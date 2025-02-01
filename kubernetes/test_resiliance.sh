#!/bin/bash

URL="https://a13a70995aa78448f88c1a5185c22585-2058242124.us-east-1.elb.amazonaws.com/api/information/room-information"
NAMESPACE="hotelup"
POD_NAME_PREFIX="information-deployment"
POD_NAME=$(kubectl get pods -n $NAMESPACE -o custom-columns=":metadata.name" | grep $POD_NAME_PREFIX | head -n 1)
DURATION=20
SLEEP_INTERVAL=1

start_time=$(date +%s)
downtime_start=0
downtime_end=0
kill_time=$((start_time + 5))

POD_COUNT=$(kubectl get pods -n $NAMESPACE -o custom-columns=":metadata.name" | grep -c $POD_NAME_PREFIX)
echo "Starting test..."
echo "Number of pods with prefix: $POD_COUNT"
while true; do
    current_time=$(date +%s)
    elapsed=$((current_time - start_time))
    
    if [ "$elapsed" -ge "$DURATION" ]; then
        break
    fi
    
    http_code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 2 -k $URL)
    
    if [[ "$http_code" =~ ^5[0-9]{2}$ ]] || [ "$http_code" -eq "000" ]; then
        echo "[$elapsed s] Status: $http_code (downtime detected)"
        if [ "$downtime_start" -eq 0 ]; then
            downtime_start=$elapsed
        fi
    else
        echo "[$elapsed s] Status: $http_code"
        if [ "$downtime_start" -ne 0 ] && [ "$downtime_end" -eq 0 ]; then
            downtime_end=$elapsed
        fi
    fi
    
    if [ "$current_time" -ge "$kill_time" ]; then
        echo "Killing pod $POD_NAME..."
        kubectl delete pod $POD_NAME -n $NAMESPACE
        kill_time=$((current_time + DURATION)) # Prevent multiple deletions
    fi
    
    sleep $SLEEP_INTERVAL
done

if [ "$downtime_start" -ne 0 ] && [ "$downtime_end" -eq 0 ]; then
    downtime_end=$((current_time - start_time))
fi

downtime_duration=$((downtime_end - downtime_start))
echo "Downtime duration: $downtime_duration seconds"