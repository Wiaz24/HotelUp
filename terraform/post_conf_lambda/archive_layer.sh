#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdir -p $SCRIPT_DIR/lambda-layer/python
mkdir -p $SCRIPT_DIR/lambda-layer/certs

cd $SCRIPT_DIR/lambda-layer

python3 -m venv env
source env/bin/activate

pip install --target=./python requests urllib3

cp ../certs/certificate.pem ./certs/certificate.pem

zip -r ./lambda-layer.zip python certs
cd ..