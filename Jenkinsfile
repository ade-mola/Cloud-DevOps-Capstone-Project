pipeline {
    environment {
        registry = "ademola/devops-capstone"
        ECRURI = "020483229178.dkr.ecr.us-east-2.amazonaws.com/ademola/devops-capstone"
        ECRURL = "https://020483229178.dkr.ecr.us-east-2.amazonaws.com/ademola/devops-capstone"
        ECRCRED = "devops-credentials"
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
                    withDockerRegistry(ECRURL, ECRCRED) {
                    sh ' docker push ademola/devops-capstone'
                    }
                    
                }
            }
        }

        stage ('Rolling deployment to AWS') {
            steps {
               script {
                    withAWS(credentials: 'devops-credentials', region: 'us-east-2'){
                    sh "aws eks --region us-east-2 update-kubeconfig --name devops-project"
                    sh 'kubectl apply -f rolling.yml'
                  }
               }
            }
        }

    }
}