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
                script {
                    sh "docker build -t ${DOCKER_HUB_REPO}:latest ."
                }
            }
        }

        stage('Push to DockerHub') {
    steps {
        withCredentials([usernamePassword(
            credentialsId: 'docker',       // <-- your Jenkins credential ID
            usernameVariable: 'DOCKER_USER',
            passwordVariable: 'DOCKER_PASS'
        )]) {
            sh '''
                echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                docker tag deepak1447/train-ticket-reservation:latest $DOCKER_USER/train-ticket-reservation:latest
                docker push $DOCKER_USER/train-ticket-reservation:latest
                docker logout
            '''
        }
    }
}


        stage('Deploy (Optional)') {
            steps {
                echo "Deployment stage — customize for your server or Kubernetes cluster"
                // Example:
                // sh "docker run -d -p 8080:8080 ${DOCKER_HUB_REPO}:latest"
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
