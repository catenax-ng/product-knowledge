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
RUN if [ "${HTTP_PROXY}" != ""  ]; then \
        echo "Acquire::http::Proxy \"${HTTP_PROXY}\"" >> /etc/apt/apt.conf.d/proxy.conf; \
        echo "Acquire::https::Proxy \"${HTTP_PROXY}\"" >> /etc/apt/apt.conf.d/proxy.conf; \
    fi && \
    apt-get -y upgrade && \
    apt-get -y update && \
    apt-get -y --no-install-recommends install unzip=6.0-26ubuntu3 && \
    addgroup --system --gid 30000 tomcat && \
    adduser --disabled-password --gecos "" --ingroup tomcat --uid 10000 tomcat && \
    rm -rf /usr/local/tomcat/webapps/* && \
    if [ "${HTTP_PROXY}" != ""  ]; then rm -f /etc/apt/apt.conf.d/proxy.conf; fi && \
    wget -q -O /tmp/rdf4j.zip "https://rhlx01.hs-esslingen.de/pub/Mirrors/eclipse/rdf4j/eclipse-rdf4j-4.2.1-sdk.zip" && \
    unzip -d /tmp /tmp/rdf4j.zip eclipse-rdf4j-4.2.1/war/rdf4j-server.war  eclipse-rdf4j-4.2.1/war/rdf4j-workbench.war && \
    rm /tmp/rdf4j.zip

RUN	mkdir -p /var/rdf4j/server/conf && \
    mkdir -p /var/rdf4j/server/repositories && \
    unzip /tmp/eclipse-rdf4j-4.2.1/war/rdf4j-server.war -d /usr/local/tomcat/webapps/rdf4j-server && \
	unzip /tmp/eclipse-rdf4j-4.2.1/war/rdf4j-workbench.war -d /usr/local/tomcat/webapps/rdf4j-workbench && \
    rm -rf /tmp/eclipse-rdf4j-4.2.1 && \
    wget -q "https://repo1.maven.org/maven2/org/apache/httpcomponents/httpmime/4.5.13/httpmime-4.5.13.jar" -O /usr/local/tomcat/webapps/rdf4j-server/WEB-INF/lib/httpmime-4.5.13.jar && \
    chown -R tomcat:tomcat /var/rdf4j /usr/local/tomcat && \
	chmod 775 /usr/local/tomcat /usr/local/tomcat/bin /usr/local/tomcat/bin/catalina.sh /var/rdf4j/server 

COPY resources/web/logging.properties /usr/local/tomcat/conf/logging.properties
COPY resources/web/server.xml /usr/local/tomcat/conf/server.xml
COPY resources/web/web.xml /usr/local/tomcat/conf/web.xml
COPY resources/web/tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml

USER tomcat

COPY target/original-remoting-agent-*-SNAPSHOT.jar /usr/local/tomcat/webapps/rdf4j-server/WEB-INF/lib/.

WORKDIR /usr/local/tomcat/

# never got this syntax to work with docker-compose
#VOLUME /var/rdf4j
#VOLUME /usr/local/tomcat/logs

EXPOSE 8081

