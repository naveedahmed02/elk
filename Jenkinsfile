pipeline {
    environment {
        DOCKER_COMPOSE_FILE_NAME = 'docker-compose.yml'
        ENV_FILE = 'env'
        // DEPLOYMENT_NAME = 'psw-deployment'

    }
    agent { label 'any' }
    
        stage('Stopping all services') {
            steps {
                sh "docker-compose ${ENV_FILE} -f ${DOCKER_COMPOSE_FILE_NAME} down --remove-orphans"
            }
        }
        stage('Starting all services') {
            steps {
                sh "docker-compose -${ENV_FILE} -f ${DOCKER_COMPOSE_FILE_NAME} up -d"
            }
        }
    }