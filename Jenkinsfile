pipeline {
    agent { label 'Dev-Agent' }

    environment {
        DOCKER_IMAGE = 'nimitha1111/my-httpd-image'
        DOCKER_CREDENTIALS = 'dockerhub_credentials_id'
        GITHUB_CREDENTIALS = 'github-credentials-id'  // GitHub credentials ID from Jenkins
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    checkout([$class: 'GitSCM',
                        branches: [[name: '*/main']],
                        userRemoteConfigs: [[
                            url: 'https://github.com/Venanciusnimitha/jenkins-cicd-project-1.git',
                            credentialsId: GITHUB_CREDENTIALS
                        ]]
                    ])
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE}:latest")
                }
            }
        }

        stage('Login to Docker Hub and Push Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS) {
                        dockerImage.push('latest')
                    }
                }
            }
        }

        stage('Deploy using Docker Compose') {
            steps {
                script {
                    sh '''
                    echo "Stopping running containers..."
                    docker-compose down || true
                    
                    echo "Starting new containers..."
                    docker-compose up -d
                    '''
                }
            }
        }
    }

    post {
        success {
            echo '✅ Build, push, and deployment successful!'
        }
        failure {
            echo '❌ Build or deployment failed. Check the logs for errors.'
        }
    }
}
