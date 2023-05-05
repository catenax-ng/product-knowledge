#
# Docker buildfile for setting up the skill gym
# See copyright notice in the top folder
# See authors file in the top folder
# See license file in the top folder
#

###
# Build Stage, add --platform=linux/arm64 if the build is slow on Apple Silicon
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

RUN apk update && apk add --no-cache ca-certificates=20190108-r0 && update-ca-certificates

# Build time arguments (WebVOWL version)
ARG VERSION=1.1.7
# Runtime variables
ENV REACT_APP_SKILL_CONNECTOR_DATA=http://localhost:8500
ENV REACT_APP_SKILL_CONNECTOR_CONTROL=http://localhost:8600
ENV REACT_APP_SKILL_CONNECTOR_AUTH_HEADER_KEY=X-Api-Key
ENV REACT_APP_SKILL_CONNECTOR_AUTH_HEADER_VALUE=foo
ENV REACT_APP_SKILL_BACKEND=http://localhost:3000/webvowl/index.html
ENV REACT_APP_SKILL_GITHUB_ONTOLOGYHUB=https://api.github.com/repos/catenax-ng/product-knowledge/contents/ontology
ENV REACT_APP_FOLDER=/consumer-frontend

# integrate the static node result
COPY resources/entrypoint.sh /usr/local/tomcat/bin/

# Download WebVOWL to tomcat webapps directory
RUN rm -rf /usr/local/tomcat/webapps/* && \
    wget -O /usr/local/tomcat/webapps/webvowl.war http://vowl.visualdataweb.org/downloads/webvowl_${VERSION}.war && \
    addgroup --system --gid 30000 tomcat && \
    adduser --disabled-password --gecos "" --ingroup tomcat --uid 10000 tomcat

# integrate the static node result
COPY --from=build app/skill_gym/build /usr/local/tomcat/webapps/ROOT/

RUN chown -R tomcat:tomcat /usr/local/tomcat && \
    chmod 775 /usr/local/tomcat /usr/local/tomcat/bin /usr/local/tomcat/bin/catalina.sh && \
    chmod 775 /usr/local/tomcat/webapps/ROOT/static/js

USER tomcat

# TODO Should have a healthcheck
HEALTHCHECK NONE

EXPOSE 8080

# Run default server
CMD ["entrypoint.sh", "run"]