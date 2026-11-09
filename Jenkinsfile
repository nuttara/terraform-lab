pipeline {
    agent any

    parameters {
        choice(
            name: 'ACTION',
            choices: ['plan', 'apply', 'destroy'],
            description: 'Terraform Action'
        )
    }

    stages {

        stage('Terraform Init') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'aws-terraform-nam',
                        usernameVariable: 'AWS_ACCESS_KEY_ID',
                        passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                    )
                ]) {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Action') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'aws-terraform-nam',
                        usernameVariable: 'AWS_ACCESS_KEY_ID',
                        passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                    )
                ]) {
                    script {

                        if (params.ACTION == 'plan') {
                            sh 'terraform plan'
                        }

                        if (params.ACTION == 'apply') {
                            sh 'terraform apply -auto-approve'
                        }
                        
                        if (params.ACTION == 'destroy') {
                            input 'Confirm Destroy?'
                            sh 'terraform destroy -auto-approve'
                        }

                    }
                }
            }
        }
    }
}