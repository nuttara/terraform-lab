pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-terraform-nam_USR')
        AWS_SECRET_ACCESS_KEY = credentials('aws-terraform-nam_PSW')
    }

    stages {

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Approve') {
            steps {
                input 'Apply Terraform?'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
    }
}