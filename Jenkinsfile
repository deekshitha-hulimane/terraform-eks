pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-south-1'
    }

    triggers {
        pollSCM('H/2 * * * *')
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                url: 'https://github.com/deekshitha-hulimane/terraform-eks.git'
            }
        }

        stage('Bootstrap Backend') {
            steps {
                dir('bootstrap') {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Terraform Init') {
            steps {
                dir('main') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('main') {
                    sh 'terraform plan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('main') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
}
