pipeline {
    agent any
    environment {
        // Path to your docker-compose.yml and .env files
        COMPOSE_FILE = 'docker-compose.yml'
        ENV_FILE = '.env'
    }

    stages {
        stage('Preparation') {
            steps {
                script {
                    // Clean up any old Docker containers or networks
                    sh 'docker compose down || true'
                    // sh 'docker system prune -f || true'
                }
            }
        }

        stage('Checkout Code') {
            steps {
                // Checkout code from the repository
                checkout scm

            }
        }

        stage('Setup Docker Environment') {
            steps {
                script {
                    // Ensure the .env file exists (you can specify additional steps if necessary)
                    if (fileExists("${ENV_FILE}")) {
                        echo "Using env file for Docker Compose"
                    } else {
                        error "No env file found!"
                    }
                }
            }
        }

        stage('Build and Start ELK Stack') {
            steps {
                script {
                    // Start the ELK stack using Docker Compose with the .env file
                    sh "docker compose --file ${COMPOSE_FILE} --env-file ${ENV_FILE} up -d"
                }
            }
        }

        stage('Wait for ELK Stack to be Ready') {
            steps {
                script {
                    // Wait for Elasticsearch to be ready
                    waitUntil {
                        def esResponse = sh(script: "docker compose exec -T elasticsearch curl -s -o /dev/null -w '%{http_code}' http://localhost:9200", returnStdout: true).trim()
                        return esResponse == '200'
                    }
                    echo 'Elasticsearch is up and running.'
                    
                    // Wait for Kibana to be ready
                    waitUntil {
                        def kibanaResponse = sh(script: "docker compose exec -T kibana curl -s -o /dev/null -w '%{http_code}' http://localhost:5601", returnStdout: true).trim()
                        return kibanaResponse == '200'
                    }
                    echo 'Kibana is up and running.'
                }
            }
        }

        stage('Check ELK Stack Health') {
            steps {
                script {
                    // Check Elasticsearch cluster health
                    def esHealth = sh(script: "docker compose exec -T es01 curl -s https://localhost:9200/_cluster/health?pretty", returnStdout: true).trim()
                    echo "Elasticsearch Health: ${esHealth}"
                    
                    // Check Kibana health
                    def kibanaHealth = sh(script: "docker compose exec -T kibana curl -s http://localhost:5601/api/status | jq .status", returnStdout: true).trim()
                    echo "Kibana Health: ${kibanaHealth}"
                }
            }
        }

    }

    post {
        always {
            // Clean up after the pipeline execution
            echo 'Cleaning up Docker containers'
            sh 'docker-compose down || true'
        }

        success {
            echo 'ELK Stack is successfully deployed and healthy!'
        }

        failure {
            echo 'ELK Stack deployment failed!'
        }
    }
}