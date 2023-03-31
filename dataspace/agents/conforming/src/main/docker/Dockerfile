FROM openjdk:17-jdk-alpine
WORKDIR /app
VOLUME /tmp
COPY target/conforming-agent-*.jar /app/lib/

EXPOSE 8080
ENTRYPOINT ["java","-cp","/app/lib/*", "io.catenax.knowledge.agents.conforming.Bootstrap"]