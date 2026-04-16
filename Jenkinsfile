pipeline {
    agent any

    stages {

        stage('Bootstrap Backend') {
            steps {
                dir('bootstrap') {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Deploy Infrastructure') {
            steps {
                dir('main') {
                    sh 'terraform init'
                    sh 'terraform plan'
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
}
