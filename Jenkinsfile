pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "amarjeet001/static-web"
        DOCKER_TAG = "19"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/amarjeetchaurasiya27-cyber/static-website.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t %DOCKER_IMAGE%:%DOCKER_TAG% ."
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds',
                                 usernameVariable: 'DOCKER_USER',
                                 passwordVariable: 'DOCKER_PASS')]) {

                    bat "docker login -u %DOCKER_USER% -p %DOCKER_PASS%"
                }
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                bat "docker push %DOCKER_IMAGE%:%DOCKER_TAG%"
            }
        }

        stage('Deploy Container') {
            steps {
                bat "docker stop static-website || echo No running container"
                bat "docker rm static-website || echo No container to remove"
                bat "docker run -d -p 7765:80 --name static-website %DOCKER_IMAGE%:%DOCKER_TAG%"
            }
        }
    }

    post {
        success {
            echo "✅ Image pushed successfully & App deployed at http://<JENKINS-IP>:7765"
        }
        failure {
            echo "❌ Pipeline Failed"
        }
    }
}
