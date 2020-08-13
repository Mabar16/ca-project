#!/bin/bash

docker push "$docker_username/flaskapp:1.0-${GIT_COMMIT::4}" 
docker push "$docker_username/flaskapp:latest" &
wait
