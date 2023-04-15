#
#  Copyright (c) 2022 Mercedes-Benz Tech Innovation GmbH
#  Copyright (c) 2021,2022 Contributors to the Eclipse Foundation
#
#  See the NOTICE file(s) distributed with this work for additional
#  information regarding copyright ownership.
#
#  This program and the accompanying materials are made available under the
#  terms of the Apache License, Version 2.0 which is available at
#  https://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#  WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#  License for the specific language governing permissions and limitations
#  under the License.
#
#  SPDX-License-Identifier: Apache-2.0
#
FROM alpine:3.17.1 as otel

ENV OTEL_AGENT_LOCATION "https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/download/v1.12.1/opentelemetry-javaagent.jar"

HEALTHCHECK NONE

RUN wget ${OTEL_AGENT_LOCATION} -O /tmp/opentelemetry-javaagent.jar

FROM alpine:3.17.1

ARG JAR
ARG LIB

ARG APP_USER=faaast
ARG APP_UID=10100
ARG APP_GID=30000

ARG PROVIDER_SPARQL_ENDPOINT_ARG
ARG PROVIDER_CREDENTIAL_BASIC_ARG
ARG PROVIDER_AGENT_PLANE_ARG

ENV PROVIDER_SPARQL_ENDPOINT ${PROVIDER_SPARQL_ENDPOINT_ARG}
ENV PROVIDER_CREDENTIAL_BASIC ${PROVIDER_CREDENTIAL_BASIC_ARG}
ENV PROVIDER_AGENT_PLANE ${PROVIDER_AGENT_PLANE_ARG}
ENV TIMEOUT_SECONDS 10

RUN apk update && \
     apk add openjdk11-jre-headless=11.0.18_p10-r0 --no-cache && \
     rm -rf /var/cache/apk/*

RUN addgroup --gid "$APP_GID" --system "$APP_USER"

RUN adduser \
     --shell /sbin/nologin \
     --disabled-password \
     --gecos "" \
     --ingroup "$APP_USER" \
     --no-create-home \
     --uid "$APP_UID" \
     "$APP_USER"

RUN mkdir /app \
    && chgrp -R 0 /app \
    && chmod -R g=u /app \
    # Create directories to which FA³ST needs permissions
    && mkdir /app/resources /app/logs /app/PKI /app/USERS_PKI \
    # Grant read and write permissions on created directories
    && chmod -R ugo+rw /app/resources /app/PKI /app/USERS_PKI /app/logs
    
USER "$APP_USER"
WORKDIR /app

COPY --from=otel /tmp/opentelemetry-javaagent.jar .
COPY ${JAR} aas-bridge.jar
COPY ${LIB} ./lib/

EXPOSE 8080

HEALTHCHECK NONE

CMD "java" \
     "-javaagent:/app/opentelemetry-javaagent.jar" \
     "-Dotel.javaagent.configuration-file=/app/opentelemetry.properties" \
     "-Dotel.metrics.exporter=prometheus" \
     "-Dotel.exporter.prometheus.port=9090" \
     "-Djava.security.edg=file:/dev/.urandom" \
     "-jar" \
     "aas-bridge.jar"
