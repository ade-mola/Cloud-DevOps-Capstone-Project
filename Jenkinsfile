pipeline {
    environment {
        PROJECT = "ademola/devops-capstone"
        IMAGE = $PROJECT
        ECRURL = "https://020483229178.dkr.ecr.us-east-2.amazonaws.com/$PROJECT"
        ECRURI = "020483229178.dkr.ecr.us-east-2.amazonaws.com/$PROJECT"
        ECRCRED = 'ecr:us-east-2:ecr-credentials'
            
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
                    sh 'docker tag ademola/devops-capstone:latest 020483229178.dkr.ecr.us-east-2.amazonaws.com/ademola/devops-capstone:latest'
                }
            }
        }

        stage('Deploy Image') {
            steps {
                script {
                    withRegistry(ECRURL, ECRCRED) {
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