pipeline {
    environment {
        DOCKER_COMPOSE_FILE_NAME = 'docker-compose.yml'
        // DEPLOYMENT_NAME = 'psw-deployment'
        ENV_FILE = .env
    }
    agent { label 'qa' }
    
    stages {
        // stage('Pulling latest images') {
        //     steps {
        //         sh "docker-compose ${ENV_FILE} -f ${env.DOCKER_COMPOSE_FILE_NAME} pull"
        //     }
        // }
        stage('Stopping all services') {
            steps {
                sh "docker-compose ${ENV_FILE} -f ${DOCKER_COMPOSE_FILE_NAME} down --remove-orphans"
            }
        }
        stage('Starting Dependencies') {
            steps {
                sh "docker-compose ${ENV_FILE} -f ${DOCKER_COMPOSE_FILE_NAME} run start_dependencies"
            }
        }
        stage('Starting all services') {
            steps {
                sh "docker-compose -${ENV_FILE} -f ${DOCKER_COMPOSE_FILE_NAME} up -d"
            }
        }
    }
   
}