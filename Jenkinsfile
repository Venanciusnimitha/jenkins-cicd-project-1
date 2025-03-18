pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'nimitha1111/my-httpd-image'
        DOCKER_CREDENTIALS = 'dockerhub_credentials_id'  // Update with your Docker Hub credentials ID
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/Venanciusnimitha/jenkins-cicd-project-1.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE}:latest")
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', DOCKER_CREDENTIALS) {
                        echo 'Logged in to Docker Hub successfully!'
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', DOCKER_CREDENTIALS) {
                        dockerImage.push('latest')
                    }
                }
            }
        }
    }

    post {
        success {
            echo '✅ Docker image pushed successfully!'
        }
        failure {
            echo '❌ Build or push failed. Check logs.'
        }
    }
}
