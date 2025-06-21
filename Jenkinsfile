pipeline {
    agent any

    environment {
        IMAGE_NAME = "jobportal_django"
        CONTAINER_NAME = "jobportal_container"
        PORT = "8000"
    }

    stages {

        stage('Build Docker Image') {
            steps {
                echo "🔨 Building Docker image..."
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Run Tests') {
            steps {
                echo "🧪 Running Django tests..."
                sh 'docker run --rm $IMAGE_NAME python manage.py test'
            }
        }

        stage('Deploy') {
            steps {
                echo "🚀 Deploying Docker container..."
                sh """
                # Remove old container if it exists
                if [ \$(docker ps -aq -f name=$CONTAINER_NAME) ]; then
                    docker stop $CONTAINER_NAME || true
                    docker rm $CONTAINER_NAME || true
                fi

                # Run new container
                docker run -d \
                    --name $CONTAINER_NAME \
                    -p $PORT:8000 \
                    $IMAGE_NAME
                """
                // Optional: Logs
                sh "docker ps -a --filter name=$CONTAINER_NAME"
                sh "docker logs $CONTAINER_NAME --tail 20"
            }
        }
    }

    post {
        success {
            echo "✅ Deployed successfully! Visit: http://<your-ec2-ip>:8000"
        }
        failure {
            echo "❌ Deployment failed!"
        }
    }
}
