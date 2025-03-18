pipeline {
    agent any  // Run on any available Jenkins agent

    environment {
        DOCKER_IMAGE = 'nimitha1111/my-httpd-image'  // Your Docker Hub image
        DOCKER_CREDENTIALS = 'dockerhub_credentials_id'  // Docker Hub credentials ID in Jenkins
        GITHUB_CREDENTIALS = 'github-credentials-id'  // GitHub credentials ID in Jenkins
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    checkout([$class: 'GitSCM',
                        branches: [[name: '*/main']],  // Clone main branch
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

        stage('Run Docker Container') {
            steps {
                script {
                    // Stop and remove any existing container with the same name
                    sh '''
                    echo "Stopping and removing any existing container..."
                    docker stop my-httpd-container || true
                    docker rm my-httpd-container || true

                    echo "Running new container on port 8081..."
                    docker run -d --name my-httpd-container -p 8081:80 nimitha1111/my-httpd-image:latest
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
