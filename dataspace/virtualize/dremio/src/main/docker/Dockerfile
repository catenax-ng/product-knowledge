#
# Copyright (C) 2017 Dremio Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FROM openjdk:8-jdk as run

LABEL org.label-schema.name='dremio/dremio-oss'
LABEL org.label-schema.description='Dremio OSS.'

ARG DOWNLOAD_URL=https://download.dremio.com/community-server/22.1.1-202208230402290397-a7010f28/dremio-community-22.1.1-202208230402290397-a7010f28.tar.gz
RUN \
  mkdir -p /opt/dremio \
  && mkdir -p /var/lib/dremio \
  && mkdir -p /var/run/dremio \
  && mkdir -p /var/log/dremio \
  && mkdir -p /opt/dremio/data \
  && mkdir -p /opt/dremio/log \
  && groupadd --system -g 30000 dremio \
  && useradd --base-dir /var/lib/dremio --system -u 10000 --gid dremio dremio \
  && chown -R dremio:dremio /var/run/dremio \
  && chown -R dremio:dremio /var/log/dremio \
  && chown -R dremio:dremio /var/lib/dremio \
  && wget -q "${DOWNLOAD_URL}" -O dremio.tar.gz \
  && tar vxfz dremio.tar.gz -C /opt/dremio --strip-components=1 \
  && rm -rf dremio.tar.gz \
  && rm -f /opt/dremio/jars/3rdparty/rocksdbjni-5.14.2.jar \
  && wget -q https://repo1.maven.org/maven2/org/rocksdb/rocksdbjni/7.7.3/rocksdbjni-7.7.3-linux64.jar -O /opt/dremio/jars/3rdparty/rocksdbjni.jar \
  && wget -q https://repo1.maven.org/maven2/org/rocksdb/rocksdbjni/7.7.3/rocksdbjni-7.7.3-linux64.jar -O /opt/dremio/jars/3rdparty/rocksdbjni.jar \
  && chown -R dremio:dremio /opt/dremio

EXPOSE 9047
EXPOSE 31010
EXPOSE 45678

USER dremio

WORKDIR /opt/dremio

COPY resources/dtc_codes.json /opt/dremio/local/
COPY resources/quality_skill_data/DTC_PossibleCause_Error.xlsx /opt/dremio/local/
COPY resources/quality_skill_data/DTC.xlsx /opt/dremio/local/
COPY resources/quality_skill_data/Error_ErrorEffect.xlsx /opt/dremio/local/
COPY resources/quality_skill_data/Error_ErrorSolution.xlsx /opt/dremio/local/
COPY resources/quality_skill_data/Error.xlsx /opt/dremio/local/
COPY resources/quality_skill_data/ErrorEffect.xlsx /opt/dremio/local/
COPY resources/quality_skill_data/ErrorSolution.xlsx /opt/dremio/local/
COPY resources/quality_skill_data/Part_PossibleCause.xlsx /opt/dremio/local/
COPY resources/quality_skill_data/Part.xlsx /opt/dremio/local/
COPY resources/quality_skill_data/PossibleCause.xlsx /opt/dremio/local/

ENV DREMIO_HOME /opt/dremio
ENV DREMIO_PID_DIR /var/run/dremio
ENV DREMIO_GC_LOGS_ENABLED="no"
ENV DREMIO_LOG_DIR="/var/log/dremio"
ENV DREMIO_LOG_TO_CONSOLE=1
ENV DREMIO_MAX_MEMORY_SIZE_MB=4096
ENV SERVER_GC_OPTS="" 
#"-XX:+PrintGCDetails -XX:+PrintGCDateStamps"

# TODO Should have a healthcheck
HEALTHCHECK NONE

ENTRYPOINT ["bin/dremio", "start-fg"]