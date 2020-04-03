#!/usr/bin/env bash

dockerpath=ademola/devops-capstone

kubectl create deployment capstone --image=$dockerpath

kubectl run capstone --image=$dockerpath:latest --port=80

kubectl get pods

kubectl expose deployment capstone --port=80 --name=capstone-http

