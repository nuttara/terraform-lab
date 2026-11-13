pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    }

    parameters {
        choice(
            name: 'ACTION',
            choices: ['plan', 'apply', 'destroy'],
            description: 'เลือกคำสั่ง Terraform ที่ต้องการทำงาน'
        )
        choice(
            name: 'TFVARS_FILE',
            choices: ['fs-aws-np.tfvars'],
            description: 'เลือกไฟล์ตัวแปร Environment'
        )
    }

    stages {
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh "terraform plan -var-file=${params.TFVARS_FILE}"
            }
        }

        stage('Terraform Execute') {
            when {
                expression { params.ACTION == 'apply' || params.ACTION == 'destroy' }
            }
            steps {
                script {
                    input(
                        message: "ยืนยันการรันคำสั่ง terraform ${params.ACTION} ใช่หรือไม่?",
                        ok: 'ยืนยัน'
                    )

                    if (params.ACTION == 'apply') {
                        sh "terraform apply -var-file=${params.TFVARS_FILE} -auto-approve"
                    } else if (params.ACTION == 'destroy') {
                        sh "terraform destroy -var-file=${params.TFVARS_FILE} -auto-approve"
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
