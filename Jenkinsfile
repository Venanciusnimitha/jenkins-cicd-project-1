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
