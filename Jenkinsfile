pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = "deepak1447/train-ticket-reservation"
        DOCKER_HUB_CREDENTIALS = "docker" // Jenkins credential ID
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'master', url: 'https://github.com/Deepak1447/Train-Ticket-Reservation-System.git'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_HUB_REPO}:latest ."
            }
        }

        stage('Docker Container') {
            steps {
                script {
                    // Run a container from the image we just built
                    sh """
                        docker run -d --name train-ticket-container -p 8080:8080 ${DOCKER_HUB_REPO}:latest
                    """
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "${DOCKER_HUB_CREDENTIALS}",
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker tag ${DOCKER_HUB_REPO}:latest $DOCKER_USER/train-ticket-reservation:latest
                        docker push $DOCKER_USER/train-ticket-reservation:latest
                        docker logout
                    '''
                }
            }
        }

    post {
        success {
            echo '✅ Build and Deployment Successful!'
        }
        failure {
            echo '❌ Build or Deployment Failed!'
        }
    }
}
