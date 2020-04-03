#!/bin/bash
aws cloudformation create-stack \
--stack-name $1 \
--template-body file://$2 \
--parameters file://$3 \
--capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" \
--region=us-east-2

echo "Waiting for stack to be created ..."
aws cloudformation wait stack-create-complete --stack-name $1 
echo "Stack created!"




