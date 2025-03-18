pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git credentialsId: 'github-credentials-id', url: 'https://github.com/Venanciusnimitha/jenkins-cicd-project-1.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t myapp:latest .'
            }
        }
        stage('Login to Docker Hub') {
            steps {
                withDockerRegistry([credentialsId: 'dockerhub_credentials_id', url: '']) {
                    sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                sh 'docker push myapp:latest'
            }
        }
    }
}