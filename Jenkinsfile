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
                    docker.withRegistry('https://registry.hub.docker.com', DOCKER_CREDENTIALS) {
                        dockerImage.push('latest')
                    }
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Stop and remove the existing container if running
                    sh '''
                    echo "Stopping and removing any existing container..."
                    docker stop my-httpd-container || true
                    docker rm my-httpd-container || true

                    echo "Running new container..."
                    docker run -d --name my-httpd-container -p 8080:80 nimitha1111/my-httpd-image:latest
                    '''
                }
            }
        }
    }

    post {
        success {
            echo '✅ Build, push, and container deployment successful!'
        }
        failure {
            echo '❌ Build or deployment failed. Check the logs for errors.'
        }
    }
}
