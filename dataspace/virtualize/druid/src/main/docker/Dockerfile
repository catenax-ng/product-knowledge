#
# Docker buildfile for setting up a backend data virtualizer/source
# See copyright notice in the top folder
# See authors file in the top folder
# See license file in the top folder
#

FROM openjdk:11-jdk as run

COPY resources/setup.sh /opt/druid/bin/

ARG DOWNLOAD_URL=https://dlcdn.apache.org/druid/24.0.0/apache-druid-24.0.0-bin.tar.gz
ARG HTTP_PROXY=""
RUN if [ "${HTTP_PROXY}" != ""  ]; then \
        echo "Acquire::http::Proxy \"${HTTP_PROXY}\"" >> /etc/apt/apt.conf.d/proxy.conf; \
        echo "Acquire::https::Proxy \"${HTTP_PROXY}\"" >> /etc/apt/apt.conf.d/proxy.conf; \
    fi && \
    apt-get -y upgrade \
    && apt-get -y update \
    && apt-get -y install jq \
    && if [ "${HTTP_PROXY}" != ""  ]; then rm -f /etc/apt/apt.conf.d/proxy.conf; fi \
    && mkdir -p /opt/druid \
    && groupadd --system -g 30000 druid \
    && useradd --base-dir /opt/druid --system -u 10000 --gid druid druid \
    && wget -q "${DOWNLOAD_URL}" -O druid.tar.gz \
    && tar vxfz druid.tar.gz -C /opt/druid --strip-components=1 \
    && rm -rf druid.tar.gz \
    && chown -R druid:druid /opt/druid

COPY resources/micro-quickstart.conf /opt/druid/conf/supervise/single-server/micro-quickstart.conf
COPY resources/supervise /opt/druid/bin/supervise
COPY resources/setup.sh /opt/druid/bin/setup.sh

EXPOSE 8888
EXPOSE 8082

USER druid

WORKDIR /opt/druid

# TODO Should have a healthcheck
HEALTHCHECK NONE

ENTRYPOINT ["bin/start-micro-quickstart"]