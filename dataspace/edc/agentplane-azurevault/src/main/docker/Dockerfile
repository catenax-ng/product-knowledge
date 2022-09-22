##
##  Docker Image of the EDC Agent Dataplane
##  See copyright notice in the top folder
##  See authors file in the top folder
##  See license file in the top folder
##
FROM alpine:3.16.2 as otel

ENV OTEL_AGENT_LOCATION "https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/download/v1.12.1/opentelemetry-javaagent.jar"

RUN wget ${OTEL_AGENT_LOCATION} -O /tmp/opentelemetry-javaagent.jar

FROM gcr.io/distroless/java11-debian11@sha256:dee9240c64471f1776a6b37f315890aba14ff4bc89ad247eeb34ec79fdeb24f4
ARG JAR
ARG LIB

WORKDIR /app

COPY --from=otel /tmp/opentelemetry-javaagent.jar .
COPY ${JAR} edc-dataplane.jar
COPY ${LIB} ./lib/

USER nonroot

# TODO Should have a healthcheck
HEALTHCHECK NONE

CMD ["-javaagent:/app/opentelemetry-javaagent.jar", \
     "-Dedc.fs.config=/app/configuration.properties", \
     "-Djava.util.logging.config.file=/app/logging.properties", \
     "-Dotel.javaagent.configuration-file=/app/opentelemetry.properties", \
     "-Dotel.metrics.exporter=prometheus", \
     "-Dotel.exporter.prometheus.port=9090", \
     "-Djava.security.edg=file:/dev/.urandom", \
     "-jar", \
     "edc-dataplane.jar"]