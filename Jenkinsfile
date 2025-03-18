pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'nimitha1111/my-httpd-image'
        DOCKER_CREDENTIALS_ID = 'dockerhub_credentials_id' // Add this in Jenkins
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/Venanciusnimitha/jenkins-cicd-project-1.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                sh 'docker push $DOCKER_IMAGE'
            }
        }

        stage('Clean Up') {
            steps {
                sh 'docker rmi $DOCKER_IMAGE'
            }
        }
    }
}
