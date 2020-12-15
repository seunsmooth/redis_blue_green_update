pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh ' rm -rf redis_blue_green_update'
                sh 'git clone https://github.com/seunsmooth/redis_blue_green_update.git'
            }
        }
        stage('build  app Infrastructure') {
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