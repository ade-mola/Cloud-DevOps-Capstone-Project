[![CircleCI](https://circleci.com/gh/ade-mola/Cloud-DevOps-Capstone-Project.svg?style=shield)](https://circleci.com/gh/ade-mola/Cloud-DevOps-Capstone-Project)

# Udacity Cloud DevOps Engineer Capstone Project

The project creates a CI/CD Pipeline with Jenkins and also EKS Clusters through AWS CloudFormation and deploys a Nginx image. 

The pipeline also performs a Rolling Deployment strategy to update to the latest image version.

## Project Tasks
* Working in AWS
* Using Jenkins to implement CI/CD
* Building pipelines
* Working with CloudFormation to create and deploy clusters
* Building Kubernetes Cluster
* Building Docker containers in pipeline

## Steps
* Create an EC2 instance for Jenkins and SSH into it.
  * It is advisable to use Visual Studio to remote connect into EC2 instance. This is for easy navigation of files and folders.

* Clone this repo and run the scripts in the **install-scripts** folder to install `awscli`, `docker`, `jenkins`, and `kubectl` onto the EC2 instance.

* Create CloudFormation stack:
  ```
  ./create.sh <stack-name> eks-templates/eks.yml eks-templates/parameters.json
  ```
  The script provisions the EKS cluster

* After stack is created, configure EKS cluster with EC2 instance, using the `ClusterName` variable in CloudFormation script:
  ```
  aws eks update-kubeconfig --name devops-cluster
  ```

* Copy the `role ARN` of the Node Role from the stack output resources, into the `eks-templates/aws-auth.yml` 

* Run `aws-auth.yml` in order to extend cluster permissions to other worker nodes:
  ```
  kubectl apply -f eks-templates/aws-auth.yml
  ```

* Login to Jenkins, add necessary plugins such as **Blue Ocean, AWS Pipeline and Dokcer**, authenticate Github for Jenkins and create a new pipeline.

* After pipeline builds successfully, run `kubectl get svc` and copy the **External IP Address** and open in a browser.
