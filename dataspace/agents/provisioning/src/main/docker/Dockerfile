#
# Docker buildfile for setting up the provisioning agent using an internal h2 database
# See copyright notice in the top folder
# See authors file in the top folder
# See license file in the top folder
#

FROM ontop/ontop-endpoint:4.2.1

#start script needs special root treatmnt
COPY resources/entrypoint.sh /opt/ontop/.

# Security issue A1SLDT-828
RUN groupadd -g 30000 ontop && \
    useradd -u 10000 -g ontop -ms /bin/sh ontop && \
    mkdir /opt/ontop/jdbc && \
    chown -R ontop:ontop /opt/ontop && \
    mkdir /data && \
    chown -R ontop:ontop /data && \
    mkdir /input && \
    chown -R ontop:ontop /input && \
    mkdir /database && \
    chown -R ontop:ontop /database && \
    chmod 775 /database && \
    chmod 755 /opt/ontop/entrypoint.sh 

# run with docker --build-arg dremioDownload=download_url to establish a different driver
#ARG dremioDownload=https://download.dremio.com/jdbc-driver/dremio-jdbc-driver-LATEST.jar
#RUN wget -q "${dremioDownload}" -O /opt/ontop/jdbc/dremio-jdbc-driver-LATEST.jar

WORKDIR /opt/ontop
USER ontop

# run with docker --build-arg jdbcDriver=path_to_my_driver to establish a different driver
ARG jdbcDriver=repo/h2-2.1.214.jar 
COPY ${jdbcDriver} jdbc/

# run with docker --build-arg sqlFiles=initial_sql to establish a different sql file
ARG sqlFiles=resources/dtc.sql
COPY ${sqlFiles} /data/

# Additional Java debugging options
ARG JAVA_TOOL_OPTIONS ""

# ontop uses this as the default port
EXPOSE 8080

# These are the environment variables pointing to the various settings
# To disable a setting simply leave it empty
# To enable different settings for multiple endpoints simply separate the options with a space
ENV ONTOP_PORT=8080
ENV ONTOP_ONTOLOGY_FILE=/input/ontology.ttl
ENV ONTOP_MAPPING_FILE=/input/mapping.obda
ENV ONTOP_PROPERTIES_FILE=/input/settings.properties
ENV ONTOP_PORTAL_FILE=""
ENV ONTOP_CORS_ALLOWED_ORIGINS="*"
ENV ONTOP_DEV_MODE=true

# TODO Should have a healthcheck
HEALTHCHECK NONE

# Run Ontop Agent with CORS disabled (we expect an ingress layer anyway)
# TODO check security settings
# TODO Telemetry, instrumentation and debugging
ENTRYPOINT ["./entrypoint.sh"]

        