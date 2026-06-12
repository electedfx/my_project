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

        stage('Terraform: Init') {
            steps {
                dir(env.TF_DIR) {
                    sh 'terraform init -input=false'
                }
            }
        }

        stage('Terraform: Plan') {
            steps {
                dir(env.TF_DIR) {
                    withCredentials([string(credentialsId: 'yc-sa-token', variable: 'YC_TOKEN')]) {
                        sh '''
                           terraform plan -input=false -out=tfplan \
                              -var-file=terraform.tfvars \
                              -var="yc_token=$YC_TOKEN"
                        '''
                    }
                }
            }
        }

        stage('Terraform: Apply') {
            steps {
                dir(env.TF_DIR) {
                    withCredentials([string(credentialsId: 'yc-sa-token', variable: 'YC_TOKEN')]) {
                        sh '''
                           terraform apply -auto-approve tfplan
                        '''
                    }
                }
            }
        }

        stage('Ansible: Config infra & Deploy') {
            steps {
                sh 'sleep 15'
                
                sshagent(credentials: ['superuser']) {
                    sh '''
                        ansible-playbook ${ANSIBLE_PLAYBOOK} \
                          -i ${INVENTORY_FILE} \
                          -u superuser \
                          -e 'ansible_ssh_common_args="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"'
                    '''
                }
            }
        }
    }
}
