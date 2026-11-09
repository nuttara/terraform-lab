pipeline {
    agent any

    parameters {
        choice(
            name: 'ACTION',
            choices: ['plan', 'apply', 'destroy'],
            description: 'Terraform Action'
        )
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-terraform-nam_USR')
        AWS_SECRET_ACCESS_KEY = credentials('aws-terraform-nam_PSW')
        AWS_DEFAULT_REGION    = 'ap-southeast-1'
    }

    stages {

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Action') {
            steps {
                script {

                    if (params.ACTION == 'plan') {
                        sh 'terraform plan'
                    }

                    if (params.ACTION == 'apply') {
                        sh 'terraform apply -auto-approve'
                    }

                    if (params.ACTION == 'destroy') {
                        sh 'terraform destroy -auto-approve'
                    }

                }
            }
        }
    }
}