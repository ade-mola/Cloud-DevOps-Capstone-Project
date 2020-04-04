#!/usr/bin/env bash

sudo apt -y update
sudo apt -y upgrade

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl\
    -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

sudo chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Test kubectl, if working
# kubectl version --short --client
