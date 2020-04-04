pipeline {
    environment {
        registry = "ademola/devops-capstone"
        registryCredential = 'dockerhub'
            
    }

    agent any
    stages {
        stage ('Lint HTML') {
            steps {
                sh '''docker run --rm -i hadolint/hadolint < Dockerfile'''
                sh 'tidy -q -e *html'
            }
        }

        stage('Building Image') {
            steps {
                script {
                    sh 'docker build --tag=ademola/devops-capstone .'

                }
            }
        }

        stage('Push Image') {
            steps {
                script {
                    withDockerRegistry([ credentialsId: "dockerhub", url: "" ]) {
                    sh ' docker push ademola/devops-capstone'
                    }
                    
                }
            }
        }

        stage ('Deploy Clusters with Rolling Strategy') {
            steps {
               script {
                    withAWS(credentials: 'ecr-credentials', region: 'us-east-2'){
                   // Latest
                   sh "aws eks --region us-east-2 update-kubeconfig --name devops-cluster"
                   sh "kubectl apply -f eks-templates/aws-auth.yml"
                   sh 'kubectl apply -f rolling.yml'
                  }
               }
            }
        }

        // stage('Set Image Deployment') {
        //     steps {
        //         script {
        //             withDockerRegistry([ credentialsId: "dockerhub", url: "" ]) {
        //             // kubectl set image deployment <deployment> <container>=<image> --record
        //             sh 'kubectl set image deployment devops-capstone-deployment devops-capstone=ademola/devops-capstone:v2 --record'
        //             }
        //         }
        //     }
        // }

    }
}