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
                sh 'docker build -t prt-cicd:latest .'
            }
        }

        stage('Verify Docker Image') {
            steps {
                sh 'docker images prt-cicd'
            }
        }
    }
}
