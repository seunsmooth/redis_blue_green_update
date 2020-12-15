pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh ' rm -rf simpleweb'
                sh 'git clone https://github.com/seunsmooth/simpleweb.git'
            }
        }
        stage('build weather app Infrastructure') {
            steps {
                echo 'build Terraform infrastructure on AWS..'
                sh  'terraform init && terraform apply -auto-approve'
            }
        }
         stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}