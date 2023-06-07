#!/bin/bash

git clone https: //github.com/DefectDojo/django-DefectDojo
cd django-DefectDojo
# building
dc-build.sh

# running
dc-up.sh

#go to http://localhost:8080 on your browser

#running sonarqube docker image
docker run -d -p 9000:9000 sonarqube

#go to http://localhost:9000 on your browser
#under account>security generate user token/login key
#under project generate project token/key

#Request for Sonar Project Key Token
read -p "Enter Project Key : " projectkey
echo "$projectkey"
#Request for sonar Login Token
read -p "Enter Login Key : " loginkey
echo "$loginkey"
#Request for code repo in this format '/User/code/app/src'
read -p "copy code dir : " dir
echo "$dir"

#scan a repo locally
docker run \
    --rm \
    -e SONAR_HOST_URL="http://localhost:9000" \
    -e SONAR_SCANNER_OPTS="-Dsonar.projectKey=$projectkey" \
    -e SONAR_LOGIN="$loginkey" \
    -v "$dir:/usr/src" \
    sonarsource/sonar-scanner-cli
