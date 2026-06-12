pipeline {
    agent any

    environment {
        TF_IN_AUTOMATION = "true"
        TF_WORKSPACE     = "default"
        TF_DIR           = "terraform"
        ANSIBLE_PLAYBOOK = "ansible/playbook.yml"
        INVENTORY_FILE   = "ansible/inventory/hosts.yml"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform: Init & Format Check') {
            steps {
                dir(env.TF_DIR) {
                    sh 'terraform init -input=false'
                }
            }
        }

        stage('Terraform: Plan') {
            steps {
                dir(env.TF_DIR) {
                    withCredentials([file(credentialsId: 'yc-sa-token', variable: 'YC_SA_TOKEN')]) {
                        sh """
                            export YC_SERVICE_ACCOUNT_KEY_FILE="\$YC_SA_TOKEN"
                            terraform plan -input=false -out=tfplan -var-file=variables.tf
                        """
                    }
                }
            }
        }

        stage('Terraform: Apply') {
            steps {
                dir(env.TF_DIR) {
                    withCredentials([file(credentialsId: 'yc-sa-token', variable: 'YC_SA_TOKEN')]) {
                        sh """
                            export YC_SERVICE_ACCOUNT_KEY_FILE="\$YC_SA_TOKEN"
                            terraform apply tfplan
                        """
                    }
                }
            }
        }

        stage('Ansible: Deploy') {
            steps {
                // Небольшая пауза, чтобы cloud-init на ВМ успел обработать ключи и поднять SSH-демон
                sh 'sleep 15'
                
                // sshagent внедряет ключ в память и задает SSH_AUTH_SOCK
                sshagent(credentials: ['superuser']) {
                    sh """
                        ansible-playbook ${ANSIBLE_PLAYBOOK} \\
                          -i ${INVENTORY_FILE} \\
                          -u superuser \\
                          -e 'ansible_ssh_common_args="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"'
                    """
                }
            }
        }

}