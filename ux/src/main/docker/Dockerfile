#
# Docker buildfile for setting up the skill gym
# See copyright notice in the top folder
# See authors file in the top folder
# See license file in the top folder
#

###
# Build Stage
###
FROM node:18 as build

WORKDIR /app
COPY . /app
COPY skill_gym/.env /app/skill_gym/

RUN npm run init:dev && \
    npm run build:skillg 

###
# Operate Stage
###
FROM tomcat:9-jre8-alpine

RUN apk update && apk add ca-certificates && update-ca-certificates

# Build time arguments (WebVOWL version)
ARG VERSION=1.1.7

# Download WebVOWL to tomcat webapps directory 
RUN rm -rf /usr/local/tomcat/webapps/* && \
    wget -O /usr/local/tomcat/webapps/webvowl.war http://vowl.visualdataweb.org/downloads/webvowl_${VERSION}.war && \
    addgroup --system --gid 30000 tomcat && \
    adduser --disabled-password --gecos "" --ingroup tomcat --uid 10000 tomcat && \
    chown -R tomcat:tomcat /usr/local/tomcat && \
	chmod 775 /usr/local/tomcat /usr/local/tomcat/bin /usr/local/tomcat/bin/catalina.sh 

# integrate the static node result
COPY --from=build app/skill_gym/build /usr/local/tomcat/webapps/ROOT/

USER tomcat

# TODO Should have a healthcheck
HEALTHCHECK NONE

EXPOSE 8080

# Run default server
CMD ["catalina.sh", "run"]