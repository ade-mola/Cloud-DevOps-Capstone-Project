#!/bin/bash

aws cloudformation delete-stack \
--stack-name $1

echo "Waiting for stack to be deleted ..."
aws cloudformation wait stack-delete-complete --stack-name $1
echo "Stack deleted!"