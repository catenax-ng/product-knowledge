#
# Docker buildfile for setting up the provisioning agent 
# with knowledge agents improvements and additional jdbc drivers 
# See copyright notice in the top folder
# See authors file in the top folder
# See license file in the top folder
#

FROM ontop/ontop:5.0.0

# Switch to root
USER root

#start script needs special root treatmnt
COPY resources/entrypoint.sh /opt/ontop/.

COPY target/provisioning-agent-*.jar /opt/ontop/lib/.

# run with docker --build-arg jdbcDrivers=path_to_my_driver to establish a different driver
ARG jdbcDrivers="https://repo1.maven.org/maven2/org/apache/calcite/avatica/avatica/1.22.0/avatica-1.22.0.jar https://search.maven.org/remotecontent?filepath=com/h2database/h2/2.1.214/h2-2.1.214.jar https://download.dremio.com/jdbc-driver/dremio-jdbc-driver-LATEST.jar"

# Security issue A1SLDT-828
RUN mkdir -p /opt/ontop/jdbc && \
    for jdbcDriver in "$jdbcDrivers"; do wget --no-check-certificate -q -P /opt/ontop/jdbc ${jdbcDriver} ; done && \
    mkdir -p /opt/ontop/data && \
    mkdir -p /opt/ontop/input && \
    mkdir -p /opt/ontop/database && \
    chmod 755 /opt/ontop/entrypoint.sh && \
    chown -R ontop:ontop /opt/ontop

# Switch back
USER ontop

# run with docker --build-arg sqlFiles=initial_sql to establish a different sql file
ARG sqlFiles=resources/dtc.sql
COPY ${sqlFiles} ./data/

# Additional Java debugging options
ARG JAVA_TOOL_OPTIONS ""

# ontop uses this as the default port
EXPOSE 8080

# These are the environment variables pointing to the various settings
# To disable a setting simply leave it empty
# To enable different settings for multiple endpoints simply separate the options with a space
ENV ONTOP_PORT=8080
ENV ONTOP_ONTOLOGY_FILE=/opt/ontop/input/ontology.ttl
ENV ONTOP_MAPPING_FILE=/opt/ontop/input/mapping.obda
ENV ONTOP_PROPERTIES_FILE=/opt/ontop/input/settings.properties
ENV ONTOP_PORTAL_FILE=""
ENV ONTOP_CORS_ALLOWED_ORIGINS="*"
ENV ONTOP_DEV_MODE=true

# TODO Reestablish the original health check
HEALTHCHECK NONE

# Run Ontop Agent with CORS disabled (we expect an ingress layer anyway)
# TODO check security settings
# TODO Telemetry, instrumentation and debugging
ENTRYPOINT ["./entrypoint.sh"]

        