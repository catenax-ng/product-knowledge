#
# Docker buildfile for the conforming agent
# See copyright notice in the top folder
# See authors file in the top folder
# See license file in the top folder
#
FROM openjdk:21-jdk-slim

COPY target/conforming-agent-*.jar /app/lib/

RUN addgroup --system --gid 30000 agent \
    && adduser --system --home /app --uid 10000 --gid 30000 agent \
    && chown -R agent:agent /app

WORKDIR /app
VOLUME /tmp
USER agent

# TODO implement wget or curl-based health check
HEALTHCHECK NONE

EXPOSE 8080

ENTRYPOINT ["java","-cp","/app/lib/*", "io.catenax.knowledge.agents.conforming.Bootstrap"]