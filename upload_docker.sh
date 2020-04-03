#!/usr/bin/env bash
# This script tags and upload an image to Docker hub
# Assumes that image is built via 'run_docker.sh'

# Create dockerpath
# dockerpath=<docker ID path>
dockerpath=ademola/devops-capstone

# Authenticate and tag
echo "Docker ID and Image: $dockerpath"
docker login 
docker tag devops-capstone:latest $dockerpath:latest

# Push image to docker repo
docker push $dockerpath:latest 
