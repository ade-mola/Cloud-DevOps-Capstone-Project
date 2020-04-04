#!/usr/bin/env bash

sudo apt -y install python3-pip
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py 

pip3 install awscli --upgrade 

# check aws version
# aws --version