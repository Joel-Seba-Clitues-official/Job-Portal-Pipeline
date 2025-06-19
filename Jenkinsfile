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
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'docker run --rm $IMAGE_NAME python manage.py test'
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh '''
                    if [ $(docker ps -q -f name=$CONTAINER_NAME) ]; then
                        docker stop $CONTAINER_NAME
                        docker rm $CONTAINER_NAME
                    fi

                    docker run -d \
                        --name $CONTAINER_NAME \
                        -p $PORT:8000 \
                        $IMAGE_NAME
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "Visit http://<your-ec2-ip>:8000"
        }
    }
}
