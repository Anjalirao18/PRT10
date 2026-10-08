pipeline {
    agent any

    environment {
        // Change these variables to match your Docker Hub setup
        DOCKER_HUB_USER  = 'anjali1551'
        IMAGE_NAME       = 'anjali1551/prt-ci-cd'
        CREDENTIALS_ID   = 'dockerhub-login' // The ID of your credentials in Jenkins
    }

    stages {
        stage('Pull Code') {
            steps {
                // If using a Pipeline from SCM, this pulls your code automatically.
                // Otherwise, you can explicitly pull from your repo like this:
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker Image..."
                    // Builds the image and tags it with both the build number and 'latest'
                    sh "docker build -t ${DOCKER_HUB_USER}/${IMAGE_NAME}:${IMAGE_TAG} ."
                    sh "docker build -t ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest ."
                }
            }
        }

        stage('Verify Docker Image') {
            steps {
                script {
                    echo "Verifying Docker Image..."
                    // Example verification 1: Check if the image exists locally
                    sh "docker image inspect ${DOCKER_HUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}"
                    
                    // Example verification 2: Run a quick health/smoke test inside the container
                    // sh "docker run --rm ${DOCKER_HUB_USER}/${IMAGE_NAME}:${IMAGE_TAG} npm test" 
                }
            }
        }

        stage('Login & Push to Docker Hub') {
            steps {
                // Securely fetch credentials from Jenkins credential store
                withCredentials([usernamePassword(credentialsId: env.CREDENTIALS_ID, 
                                                 usernameVariable: 'DOCKER_USER', 
                                                 passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        echo "Logging into Docker Hub..."
                        sh "echo ${DOCKER_PASS} | docker login -u ${DOCKER_USER} --password-stdin"
                        
                        echo "Pushing Docker Image..."
                        sh "docker push ${DOCKER_HUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}"
                        sh "docker push ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest"
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                echo "Cleaning up local environment..."
                // Log out of Docker Hub for security reasons
                sh "docker logout"
                
                // Optional: Remove local images to save disk space on the Jenkins agent
                sh "docker rmi ${DOCKER_HUB_USER}/${IMAGE_NAME}:${IMAGE_TAG} || true"
                sh "docker rmi ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest || true"
            }
        }
    }
}
    

