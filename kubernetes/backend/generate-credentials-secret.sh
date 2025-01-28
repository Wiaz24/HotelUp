#!/bin/bash

kubectl create secret generic aws-credentials -n hotelup \
    --from-file=credentials=$HOME/.aws/credentials