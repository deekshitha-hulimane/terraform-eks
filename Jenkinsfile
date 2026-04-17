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
        withCredentials([usernamePassword(
            credentialsId: 'd594bc1b-ba1a-4b65-aa91-b22dbc631b10',
            usernameVariable: 'ACCESS_KEY',
            passwordVariable: 'SECRET_KEY'
        )]) {
            dir('bootstrap') {
                bat '''
                set AWS_ACCESS_KEY_ID=%ACCESS_KEY%
                set AWS_SECRET_ACCESS_KEY=%SECRET_KEY%
                terraform init
                :: The "|| exit 0" tells Jenkins to keep going even if the bucket already exists
                terraform apply -auto-approve || exit 0
                '''
            }
        }
    }
}

        stage('Terraform Init') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'd594bc1b-ba1a-4b65-aa91-b22dbc631b10',
                    usernameVariable: 'ACCESS_KEY',
                    passwordVariable: 'SECRET_KEY'
                )]) {
                    dir('main') {
                        bat '''
                        set AWS_ACCESS_KEY_ID=%ACCESS_KEY%
                        set AWS_SECRET_ACCESS_KEY=%SECRET_KEY%
                        terraform init
                        '''
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'd594bc1b-ba1a-4b65-aa91-b22dbc631b10',
                    usernameVariable: 'ACCESS_KEY',
                    passwordVariable: 'SECRET_KEY'
                )]) {
                    dir('main') {
                        bat '''
                        set AWS_ACCESS_KEY_ID=%ACCESS_KEY%
                        set AWS_SECRET_ACCESS_KEY=%SECRET_KEY%
                        terraform plan
                        '''
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'd594bc1b-ba1a-4b65-aa91-b22dbc631b10',
                    usernameVariable: 'ACCESS_KEY',
                    passwordVariable: 'SECRET_KEY'
                )]) {
                    dir('main') {
                        bat '''
                        set AWS_ACCESS_KEY_ID=%ACCESS_KEY%
                        set AWS_SECRET_ACCESS_KEY=%SECRET_KEY%
                        terraform apply -auto-approve
                        '''
                    }
                }
            }
        }
    }
}
