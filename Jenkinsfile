pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = "deepakcharan9988/train-ticket-reservation" // DockerHub username/repo
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
                        docker push ${DOCKER_HUB_REPO}:latest
                        docker logout
                    '''
                }
            }
        }

        stage('Deploy (Optional)') {
            steps {
                echo "Deployment stage — customize for your server or Kubernetes cluster"
                // Example for Kubernetes deployment:
                // sh "kubectl apply -f k8s/deployment.yaml"
            }
        }
    }
}
