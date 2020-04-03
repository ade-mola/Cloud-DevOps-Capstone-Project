pipeline {
    environment {
        registry = "ademola/devops-capstone"
        registryCredential = "docker-hub"
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
                    withDockerRegistry([ credetialsId: "docker-hub", url: ""]) {
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