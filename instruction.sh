#!/bin/bash

USER=`whoami`
CONTAINER_NAME=dev3-nginx
color_em=`tput setaf 30`
color_red=`tput setaf 1`
color_yel=`tput setaf 3`
color_cyan=`tput setaf 6`
color_reset=`tput sgr0`
DOCKER_ID=$1
DOCKER_PASSWORD=$2

function new_line () {
    echo
}
function write () {
    echo $1
    $2
    sleep 0.2
}

echo $color_em
new_line
write '####################################' new_line
echo '#    DX_DEV3  WEDNESDAY SESSION    #'
new_line
write '####################################' new_line
echo $color_reset

write "Hello, ${color_red}${USER}${color_reset}"!
write "Welcome to this hands-on session ::: ${color_yel}deploying nginx api gateway${color_reset}.\n\nBefore setting off on a journey of 나만의 대문, please follow some instructions.\nARe YoU ${color_cyan}REady${color_reset}? [y/n]" new_line

while read x; do
    if [ $x == 'y' ]; then break
    fi
    echo "Are you READY?????? You actually have no choice. 😜 [y/n]"
done

new_line
write '1) Run Docker Desktop [enter]' new_line
# DOCKER_STATUS=`docker ps`
# echo $DOCKER_STATUS
# if [[ $DOCKER_STATUS == CONTAINER* ]]; then break
# fi
read x

write "2) Port number 4000 should remain idle. Go and check! [enter]" new_line
read x

write '4) Run the Nginx Docker container' new_line
write 'wait...' new_line

# echo $DOCKER_PASSWORD | docker login --username=$DOCKER_ID --password-stdin

if [[ $(docker ps -a --format "table{{.Names}}" | grep $CONTAINER_NAME) == $CONTAINER_NAME ]]; then
docker rm -f $CONTAINER_NAME
fi

docker run -d --rm --name dev3-nginx \
    -p4000:443 \
    shinecheyenne/$CONTAINER_NAME:latest

docker ps | grep $CONTAINER_NAME
new_line

write '5) Open new terminal window
\nCopy and paste the following commands and get back here.' new_line

write "${color_yel}docker logs --tail 10 -f ${CONTAINER_NAME}${color_reset}\n[enter]" new_line
read x

write '6) Connect to a bash shell in the container.\n' new_line

write 'By default, all nginx-related files are located in /etc/nginx directory.
\nIf you are new to nginx, I recommend browsing the directories and files to get a rough picture of the nginx structure.\n' new_line

write 'When image being built, vim & openssl were installed.
\n\nTemporary ssl certificate files - .key and .crt 
were planted in /etc/ssl/certs/ and /etc/ssl/private/ respectively in advance for your convenience.\n' new_line

write 'Also, nginx log files are forwarded to the docker log collector.
\nThis will allow you to monitor your customized logs using docker logs command.\n' new_line

write 'OK! Now is your time. Who will open the door first and win this race?!' new_line

docker exec -it $CONTAINER_NAME bash
cd /etc/nginx

