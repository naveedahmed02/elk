DEPLOYMENT_NAME="elk-deployment"
DOCKER_COMPOSE_FILE_NAME="docker-compose.yml"
ENV_FILE="env"

echo "The service list is:" 
list=`echo $Services | sed -r "s/,+/ /g" `
echo $list 

echo "The following files can be seen:"
ls -ltrh

docker compose --env-file ${ENV_FILE} -f ${DOCKER_COMPOSE_FILE_NAME} pull $list
docker compose --env-file ${ENV_FILE} -f ${DOCKER_COMPOSE_FILE_NAME} down --remove-orphans -v $list
docker compose --env-file ${ENV_FILE} -f ${DOCKER_COMPOSE_FILE_NAME} up -d $list
