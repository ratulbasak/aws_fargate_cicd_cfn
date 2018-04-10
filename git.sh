#!/bin/bash

######################################################################################
############# This script will increment the port in Dockerfile && Nginx #############
######################################################################################


######################################################################################
############# CHANGE ENV PORT IN DOCKERFILE & NGINX #############
######################################################################################

get_api_port=`grep -o 'port=.*' Dockerfile`


api_port=`echo $get_api_port | awk 'match($0,"="){print substr($0,RSTART+1,4)}'`
echo 'previous_api_port : ' $api_port
changed_api_port=`echo $(($api_port + 1))`

sed -i "s/^ENV port=$api_port *$/ENV port=$changed_api_port/" Dockerfile
echo 'changed ENV ASPNETCORE_URLS port TO in DOCKERFILE : ' $changed_api_port

sed -i "s/server 127.0.0.1:$api_port/server 127.0.0.1:$changed_api_port/" nginx/nginx.conf
echo 'changed server 127.0.0.1:PORT in NGINX : ' $changed_api_port

echo ''
echo ''
echo ''

#####################################################################################
############ CHANGE EXPOSE PORT IN DOCKERFILE, NGINX & YML #############
#####################################################################################

get_nginx_in_dockerfile=`grep -o 'EXPOSE .*' Dockerfile`

nginx_port=`echo $get_nginx_in_dockerfile | awk 'match($0," "){print substr($0,RSTART+1,4)}'`
echo 'previous_nginx_port : ' $nginx_port
changed_nginx_port=`echo $(($nginx_port + 1))`

sed -i "s/^EXPOSE .*$/EXPOSE $changed_nginx_port/" Dockerfile
echo 'changed EXPOSE port TO in DOCKERFILE: ' $changed_nginx_port

sed -i "s/listen .*$/listen $changed_nginx_port;/" nginx/nginx.conf
echo 'changed LISTEN port in NGINX: ' $changed_nginx_port


sed -i "s/Default: $nginx_port/Default: $changed_nginx_port/" fargate_from_scratch.yml
echo 'changed DEFAULT port for CONTAINER in YML: ' $changed_nginx_port


echo ''
echo ''
echo ''


#####################################################################################
############ CHANGE VERSION NUMBER IN YML & NGINX #############
#####################################################################################


get_api_location=`grep -o 'location .*' nginx/nginx.conf`


api_location=`echo $get_api_location | awk 'match($0,"v"){print substr($0,RSTART+1,1)}'`
echo 'previous_api_location : ' $api_location
changed_api_location=`echo $(($api_location + 1))`
echo 'changed location: ' $changed_api_location
sed -i "s/v$api_location/v$changed_api_location/" nginx/nginx.conf
echo 'changed API PATH LOCATION in NGINX : ' $changed_api_location


sed -i "s/v$api_location/v$changed_api_location/g" fargate_from_scratch.yml
echo 'changed API PATH LOCATION in YML : ' $changed_api_location


echo ''
echo ''
echo ''




#####################################################################################
###################### CHANGE PRIORITY NUMBER IN YML ###################
#####################################################################################

find_priority=`awk '/Priority:/{nr[NR+2]}; NR in nr' fargate_from_scratch.yml`


get_priority_number=`echo $find_priority | awk 'match($0,":"){print substr($0,RSTART+1,2)}'`

echo 'get priority number: ' $get_priority_number

changed_priority_number=`echo $(($get_priority_number + 1))`
echo 'changed priority: ' $changed_priority_number
####### SPACING AFTER DEFAULT: 2   NEEDED ###########3
sed -i "s/Default:$get_priority_number  /Default: $changed_priority_number  /" fargate_from_scratch.yml
echo 'changed PRIORITY NUMBER in YML: ' $changed_priority_number
