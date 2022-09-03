#
# Docker buildfile for setting up the remoting agent 
# See copyright notice in the top folder
# See authors file in the top folder
# See license file in the top folder
#

FROM tomcat:8.5-jre11-temurin

ENV JAVA_OPTS="-Xmx2g"
ENV CATALINA_OPTS="-Dorg.eclipse.rdf4j.appdata.basedir=/var/rdf4j"
# Additional Java debugging options
ARG JAVA_TOOL_OPTIONS ""

# TODO Should have a healthcheck
HEALTHCHECK NONE

ARG HTTP_PROXY=""
RUN if [[ -n "${HTTP_PROXY}"  ]]; then echo "Acquire::http::Proxy \"${HTTP_PROXY}\"" >> /etc/apt/apt.conf.d/proxy.conf; fi
RUN if [[ -n "${HTTP_PROXY}" ]]; then echo "Acquire::https::Proxy \"${HTTP_PROXY}\"" >> /etc/apt/apt.conf.d/proxy.conf; fi
RUN apt-get -y upgrade
RUN apt-get -y update
RUN if [[ -n "${HTTP_PROXY}"  ]]; then rm -f /etc/apt/apt.conf.d/proxy.conf; fi

RUN apt install unzip
RUN adduser --system tomcat

RUN	rm -rf /usr/local/tomcat/webapps/* 

COPY repo/*.war /usr/local/tomcat/webapps/.

RUN	mkdir -p /var/rdf4j && \
	unzip /usr/local/tomcat/webapps/rdf4j-server.war -d /usr/local/tomcat/webapps/rdf4j-server && \
	unzip /usr/local/tomcat/webapps/rdf4j-workbench.war -d /usr/local/tomcat/webapps/rdf4j-workbench && \
    rm /usr/local/tomcat/webapps/rdf4j-server.war && \
    rm /usr/local/tomcat/webapps/rdf4j-workbench.war && \
    wget -q "https://repo1.maven.org/maven2/org/apache/httpcomponents/httpmime/4.5.13/httpmime-4.5.13.jar" -O /usr/local/tomcat/webapps/rdf4j-server/WEB-INF/lib/httpmime-4.5.13.jar && \
    chown -R tomcat /var/rdf4j /usr/local/tomcat && \
	chmod a+x /usr/local/tomcat /usr/local/tomcat/bin /usr/local/tomcat/bin/catalina.sh

COPY resources/web/logging.properties /usr/local/tomcat/conf/logging.properties
COPY resources/web/server.xml /usr/local/tomcat/conf/server.xml
COPY resources/web/web.xml /usr/local/tomcat/conf/web.xml

USER tomcat

COPY target/original-agents.remoting-0.5.2-SNAPSHOT.jar /usr/local/tomcat/webapps/rdf4j-server/WEB-INF/lib/agents.remoting-0.5.2-SNAPSHOT.jar

WORKDIR /usr/local/tomcat/

# never got this syntax to work with docker-compose
#VOLUME /var/rdf4j
#VOLUME /usr/local/tomcat/logs

EXPOSE 8081

