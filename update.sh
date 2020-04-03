#!/bin/bash

aws cloudformation update-stack \
--stack-name $1 \
--template-body file://$2 \
--parameters file://$3 \
--capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" \
--region=us-east-2

echo "Waiting for stack update to complete ..."
aws cloudformation wait stack-update-complete --stack-name $1

