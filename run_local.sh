
#
# Copyright (c) 2021 T-Systems International GmbH (Catena-X Consortium)
#
# See the AUTHORS file(s) distributed with this work for additional
# information regarding authorship.
#
# See the LICENSE file(s) distributed with this work for
# additional information regarding license terms.
#

#
# Shell script to build and run a federated semantics/triple store/SPARQL backend for experimental purposes.
#
# Prerequisites: 
#   Windows, (git)-bash shell, java 11 (java) and maven (mvn) in the $PATH.
#
# Synposis: 
#   ./run_local.sh (-build)? (-clean)? (-suspend)? (-debug)? (-central|-domain1|-domain2|-connector|-edc)
#
# Comments: 
#

DEBUG_PORT=8888
DEBUG_SUSPEND=n
DEBUG_OPTIONS=
DB_FILE=./target
CLEAN_DB=n
FUSEKI_CONFIG="config-connector.ttl"
FUSEKI_PORT=8181
USE_FUSEKI=false

for var in "$@"
do
  case $var in 
  
  "-debug")
    DEBUG_OPTIONS="-agentlib:jdwp=transport=dt_socket,address=${DEBUG_PORT},server=y,suspend=${DEBUG_SUSPEND}"
    ;;

  "-build")
    cd jena
    cd jena-fuseki2
    mvn install -DskipTests
    cd ..
    cd ..
    cd DataSpaceConnector
    ./gradlew -Dhttps.proxyHost=${HTTP_PROXYHOST} -Dhttps.proxyPort=${HTTP_PROXYPORT} publishToMavenLocal -x test
    cd ..
    ./gradlew -Dhttps.proxyHost=${HTTP_PROXYHOST} -Dhttps.proxyPort=${HTTP_PROXYPORT} build
    ;;

  "-suspend")
    DEBUG_SUSPEND=y
    ;;

   "-clean")
    CLEAN_DB=y
    mvn clean
    ;;

    "-central")
     FUSEKI_CONFIG="config-federation.ttl"
     FUSEKI_PORT=2121
     USE_FUSEKI=true
     ;;

    "-domain1")
     FUSEKI_CONFIG="config-federated1.ttl"
     FUSEKI_PORT=2122
     USE_FUSEKI=true
     ;;

    "-domain2")
     FUSEKI_CONFIG="config-federated2.ttl"
     FUSEKI_PORT=2123
     USE_FUSEKI=true
     ;;

    "-connector")
     FUSEKI_CONFIG="config-connector.ttl"
     FUSEKI_PORT=2121
     USE_FUSEKI=true
     ;;

    "-edc")
     FUSEKI_CONFIG="config-connector.ttl"
     FUSEKI_PORT=8181
     USE_FUSEKI=false
     ;;

   esac

done

if [ "$CLEAN_DB" == "y" ]; then
  rm -rf ${DB_FILE}*
fi

if [ "$USE_FUSEKI" == "true" ]; then
  CALL_ARGS="-classpath jena/jena-fuseki2/jena-fuseki-server/target/jena-fuseki-server-4.4.0-SNAPSHOT.jar \
           $DEBUG_OPTIONS org.apache.jena.fuseki.main.cmds.FusekiMainCmd \
           --config ${FUSEKI_CONFIG} --port ${FUSEKI_PORT} --auth=basic" 
else
  CALL_ARGS="$DEBUG_OPTIONS -Dweb.http.port=${FUSEKI_PORT} -jar build/libs/sparql-federation.jar" 
fi

java ${CALL_ARGS}

