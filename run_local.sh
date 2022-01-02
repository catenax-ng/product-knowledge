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
#   ./run_local.sh (-all)? (-build)? (-clean)? (-suspend)? (-debug)? (-central|-tenant1|-tenant2|-complete) (-external|-internal)?
#
# Comments: 
#

DEBUG_PORT=8888
DEBUG_SUSPEND=n
DEBUG_OPTIONS=
DB_FILE=./target
CLEAN_DB=n
FUSEKI_CONFIG="config-internal.ttl"
FUSEKI_PORT=2121
EDC_PORT=8181
USE_FUSEKI=false
BUILD_ALL=false
EDC_CONFIG=central.config
EDC_ID=urn:connector:central:semantics:catenax:net
ASSETS=
REMOTE_ASSETS=

for var in "$@"
do
  case $var in 
  
  "-debug")
    DEBUG_OPTIONS="-agentlib:jdwp=transport=dt_socket,address=${DEBUG_PORT},server=y,suspend=${DEBUG_SUSPEND}"
    ;;

  "-all")
    BUILD_ALL=true
    ;;

  "-build")
    if [ "${BUILD_ALL}" == "true" ]; then 
      cd jena
      git apply ../src/patch/jena.patch
      cd jena-fuseki2
      mvn install -DskipTests -Denforcer.skip=true -Dmaven.javadoc.skip=true
      cd ..
      git restore .
      cd ..
      cd DataSpaceConnector
      ./gradlew -Dhttps.proxyHost=${HTTP_PROXYHOST} -Dhttps.proxyPort=${HTTP_PROXYPORT} publishToMavenLocal -x test
      cd ..
    fi
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
     DEBUG_PORT=8888
     EDC_PORT=8181
     EDC_CONFIG=central.config
     EDC_ID=urn:connector:central:semantics:catenax:net
     ASSETS=-Dnet.catenax.semantics.connector.assets=hub#urn:x-arq:DefaultGraph@http://localhost:2121/central-hub/
     REMOTE_ASSETS=-Dnet.catenax.semantics.connector.remote.assets=hub#urn:tenant1:PropagateGraph@http://localhost:8182/\;hub#urn:tenant2:PropagateGraph@http://localhost:8183/
     ;;

    "-tenant1")
     FUSEKI_CONFIG="config-tenant1.ttl"
     FUSEKI_PORT=2122
     DEBUG_PORT=8889
     EDC_PORT=8182
     EDC_CONFIG=tenant1.config
     EDC_ID=urn:connector:tenant1:semantics:catenax:net
     ASSETS=-Dnet.catenax.semantics.connector.assets=hub#urn:x-arq:DefaultGraph@http://localhost:2121/tenant1-hub/\;hub#urn:tenant1:PropagateGraph@http://localhost:2121/tenant1-hub/
     ;;

    "-tenant2")
     FUSEKI_CONFIG="config-tenant2.ttl"
     FUSEKI_PORT=2123
     DEBUG_PORT=8887
     EDC_PORT=8183
     EDC_CONFIG=tenant2.config
     EDC_ID=urn:connector:tenant2:semantics:catenax:net
     ASSETS=-Dnet.catenax.semantics.connector.assets=hub#urn:x-arq:DefaultGraph@http://localhost:2121/tenant2-hub/\;hub#urn:tenant2:PropagateGraph@http://localhost:2121/tenant2-hub/
     ;;

    "-complete")
     FUSEKI_CONFIG="config-internal.ttl"
     FUSEKI_PORT=2121
     DEBUG_PORT=8886
     ;;

    "-external")
     USE_FUSEKI=false
     ;;

    "-internal")
     USE_FUSEKI=true
     DEBUG_PORT=8886
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
  CALL_ARGS="$DEBUG_OPTIONS -Dedc.fs.config=${EDC_CONFIG} -Dweb.http.port=${EDC_PORT} -Dedc.ids.id=${EDC_ID} -Dedc.connector.name=${EDC_ID} ${ASSETS} ${REMOTE_ASSETS} -jar build/libs/sparql-federation.jar"
fi

java ${CALL_ARGS}

