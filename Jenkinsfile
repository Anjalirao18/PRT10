pipeline {

    agent {
        label 'ci-agent'
    }

    stages {

        stage('Pull Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'sudo docker build -t anjali1551/prt-ci-cd:latest .'
            }
        }

        stage('Verify Docker Image') {
            steps {
                sh 'sudo docker images anjali1551/prt-ci-cd'
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-login',
                        usernameVariable: 'anjali1551/prt-ci-cd',
                        passwordVariable: 'dckr_pat_lPYzER9UGqjJBp17UiW8_7TRmSU'
                    )
                ]) {
                    sh '''
                        echo "$DOCKER_PASSWORD" | sudo docker login -u "$DOCKER_USERNAME" --password-stdin
                    '''
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                sh 'sudo docker push anjali1551/prt-ci-cd:latest'
            }
        }

    }
}
    

