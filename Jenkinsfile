pipeline {
    agent any
    
    environment {
        DOCKER_COMPOSE_FILE_NAME = 'docker-compose.yml'
        DEPLOYMENT_NAME = 'elk-deployment'
        ENV_FILE = 'env'
    }
    
    stages {
        stage('Stopping all services') {
            steps {
                script {             
                    sh "docker compose --env-file ${ENV_FILE} -f ${DOCKER_COMPOSE_FILE_NAME} down --remove-orphans"
                }
            }
        }

        stage('Starting all services') {
            steps {
                script {
                    sh "docker compose --env-file ${ENV_FILE} -f ${DOCKER_COMPOSE_FILE_NAME} up -d"
                }
            }
        }
    }
}