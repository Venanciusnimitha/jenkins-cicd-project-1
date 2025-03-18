pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', 
                    credentialsId: 'github-credentials-id', 
                    url: 'https://github.com/Venanciusnimitha/jenkins-cicd-project-1.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t nimitha1111/myapp:latest .'
            }
        }
        stage('Login to Docker Hub') {
            steps {
                withDockerRegistry([credentialsId: 'dockerhub_credentials_id', url: '']) {
                    echo 'Logged into Docker Hub successfully!'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                sh 'docker push nimitha1111/myapp:latest'
            }
        }
    }
}
