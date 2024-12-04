pipeline {
    agent { label 'any' }
    
    environment {
        DOCKER_COMPOSE_FILE_NAME = 'docker-compose.yml'
        ENV_FILE = 'env'  // Ensure the env file is passed correctly if needed
    }
    
    stages {
        stage('Stopping all services') {
            steps {
                script {
                    // Stop and remove containers, networks, and orphaned containers
                    sh "docker compose ${ENV_FILE} -f ${DOCKER_COMPOSE_FILE_NAME} down --remove-orphans"
                }
            }
        }

        stage('Starting all services') {
            steps {
                script {
                    // Start the services in detached mode
                    sh "docker compose ${ENV_FILE} -f ${DOCKER_COMPOSE_FILE_NAME} up -d"
                }
            }
        }
    }
}