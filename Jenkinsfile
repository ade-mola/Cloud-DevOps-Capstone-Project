pipeline {
    environment {
        registry = "ademola/devops-capstone"
        registryCredential = "docker-credential"
            
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

        stage('Deploy Image') {
            steps {
                script {
                    withDockerRegistry([ credentialsId = "docker-credential", url = ""]) {
                    sh ' docker push ademola/devops-capstone'
                    }
                    
                }
            }
        }

        stage ('Upload latest green deployment to AWS Loadbalancer') {
            steps {
               script {
                    withAWS(credentials: 'ecr-credentials', region: 'us-east-2'){
                   // Latest
                   sh "aws eks --region us-east-2 update-kubeconfig --name devops-cluster"
                   sh 'kubectl apply -f green.yml'
                  }
               }
            }
        }

        stage ('Remove old blue deployment from AWS Loadbalancer') {
            steps {
               script {
                withAWS(credentials: 'ecr-credentials', region: 'us-east-2'){
                   sh 'kubectl delete blue-deployment'
               }
               }
            }
        }

        stage ('Add latest blue deployment to AWS Loadbalancer') {
            steps {
               script {
                   withAWS(credentials: 'ecr-credentials', region: 'us-east-2'){
                   sh 'kubectl apply -f blue.yml'
                   }
               }
            }
        }

        stage ('Remove old green deployment from AWS Loadbalancer') {
            steps {
               script {
                   withAWS(credentials: 'ecr-credentials', region: 'us-east-2'){
                   sh 'kubectl delete green-deployment'
                   }
               }
            }
        }

    }
}