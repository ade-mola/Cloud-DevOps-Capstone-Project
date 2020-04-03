#!/usr/bin/env bash

# Build image and add descriptive tag
docker build --tag=devops-capstone .

# List docker images
docker image ls 

# Run flask app
docker run -p 8000:80 devops-capstone