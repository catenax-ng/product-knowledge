#!/bin/bash

#
# Entry script for provisioning agent/ontop with the ability to start multiple endpoints
# See copyright notice in the top folder
# See authors file in the top folder
# See license file in the top folder
#

# Reinterpret the environment vars as arrays
ONTOP_PORT=( ${ONTOP_PORT[*]} )
ONTOP_ONTOLOGY_FILE=( ${ONTOP_ONTOLOGY_FILE[*]} )
ONTOP_MAPPING_FILE=( ${ONTOP_MAPPING_FILE[*]} )
ONTOP_PROPERTIES_FILE=( ${ONTOP_PROPERTIES_FILE[*]} )
ONTOP_PORTAL_FILE=( ${ONTOP_PORTAL_FILE[*]} )
ONTOP_DEV_MODE=( ${ONTOP_DEV_MODE[*]} )
JAVA_TOOL_OPTIONS_ARRAY=( ${JAVA_TOOL_OPTIONS[*]} )

ENDPOINT_LENGTH=${#ONTOP_PORT[@]}
if [[ ${ENDPOINT_LENGTH} -gt 0 ]]; then
  echo "Found ${ENDPOINT_LENGTH} endpoints to provision.";
else
  echo "Incorrect port specification: ${ONTOP_PORT[*]}";
  exit 1;
fi

((ENDPOINT_LENGTH--))

# for matching the definitions
NUMBER='^[0-9]+$'
TOML='^.*toml$'
ONTOLOGY='^.*(ttl|xml)$'
MAPPING='^.*(obda)$'
PROPERTIES='^.*(properties)$'
CORS="--cors-allowed-origins=${ONTOP_CORS_ALLOWED_ORIGINS}"

# Loop over the endpoints driven by the ports
for ENDPOINT_NUMBER in "${!ONTOP_PORT[@]}"
do
  # check port number
  if [[ "${ONTOP_PORT[${ENDPOINT_NUMBER}]}" =~ ${NUMBER} ]]; then    
    echo "Providing endpoint ${ENDPOINT_NUMBER} on port ${ONTOP_PORT[${ENDPOINT_NUMBER}]}";
    PORT="--port=${ONTOP_PORT[${ENDPOINT_NUMBER}]}";
    
    # check ontology
    if [[ "${ONTOP_ONTOLOGY_FILE[${ENDPOINT_NUMBER}]}" =~ ${ONTOLOGY} ]]; then
      echo "Providing endpoint ${ENDPOINT_NUMBER} on ontology ${ONTOP_ONTOLOGY_FILE[${ENDPOINT_NUMBER}]}";
      ONTOLOGY_FILE="--ontology=${ONTOP_ONTOLOGY_FILE[${ENDPOINT_NUMBER}]}";

      # check mapping
      if [[ "${ONTOP_MAPPING_FILE[${ENDPOINT_NUMBER}]}" =~ ${MAPPING} ]]; then

        echo "Providing endpoint ${ENDPOINT_NUMBER} on mapping ${ONTOP_MAPPING_FILE[${ENDPOINT_NUMBER}]}";
        MAPPING_FILE="--mapping=${ONTOP_MAPPING_FILE[${ENDPOINT_NUMBER}]}";

        # check properties
        if [[ "${ONTOP_PROPERTIES_FILE[${ENDPOINT_NUMBER}]}" =~ ${PROPERTIES} ]]; then

          echo "Providing endpoint ${ENDPOINT_NUMBER} on properties ${ONTOP_PROPERTIES_FILE[${ENDPOINT_NUMBER}]}";
          PROPERTIES_FILE="--properties=${ONTOP_PROPERTIES_FILE[${ENDPOINT_NUMBER}]}";

          # check developer mode
          if [ "${ONTOP_DEV_MODE[${ENDPOINT_NUMBER}]}" == "true" ]; then
            echo "Providing endpoint ${ENDPOINT_NUMBER} in developer mode";
            DEV_MODE="--dev"
          else
            DEV_MODE=""
          fi

          # check portal activation
          if [[ "${ONTOP_PORTAL_FILE[${ENDPOINT_NUMBER}]}" =~ ${TOML} ]]; then
            echo "Providing endpoint ${ENDPOINT_NUMBER} on portal ${ONTOP_PORTAL_FILE[${ENDPOINT_NUMBER}]}";
            PORTAL_FILE="--portal=${ONTOP_PORTAL_FILE[${ENDPOINT_NUMBER}]}"
          else
            PORTAL_FILE=""
          fi

          JAVA_TOOL_OPTIONS=${JAVA_TOOL_OPTIONS_ARRAY[${ENDPOINT_NUMBER}]};

          echo "Arguments: ${ONTOLOGY_FILE} ${MAPPING_FILE} ${PROPERTIES_FILE} ${PORTAL_FILE} ${DEV_MODE} ${PORT} ${CORS} ${JAVA_TOOL_OPTIONS}";

          if [[ "${ENDPOINT_NUMBER}" == "${ENDPOINT_LENGTH}" ]]; then
            echo "Invoking last process";
            java -cp ./lib/*:./jdbc/* -Dlogback.configurationFile="/opt/ontop/log/logback.xml" -Dlogging.config="/opt/ontop/log/logback.xml" \
              it.unibz.inf.ontop.cli.Ontop endpoint ${ONTOLOGY_FILE} ${MAPPING_FILE} \
              ${PROPERTIES_FILE} ${PORTAL_FILE} ${DEV_MODE} ${PORT} ${CORS};
          else 
            echo "Invoking intermediate process";
            java -cp ./lib/*:./jdbc/* -Dlogback.configurationFile="/opt/ontop/log/logback.xml" -Dlogging.config="/opt/ontop/log/logback.xml" \
              it.unibz.inf.ontop.cli.Ontop endpoint ${ONTOLOGY_FILE} ${MAPPING_FILE} \
              ${PROPERTIES_FILE} ${PORTAL_FILE} ${DEV_MODE} ${PORT} ${CORS}&
          fi

        else
          # Incorrect properties
          echo "Cannot provide endpoint ${ENDPOINT_NUMBER} as incorrect properties given: ${ONTOP_PROPERTIES_FILE[${ENDPOINT_NUMBER}]}";
        fi            
      else
        # Incorrect mapping 
        echo "Cannot provide endpoint ${ENDPOINT_NUMBER} as incorrect mapping given: ${ONTOP_MAPPING_FILE[${ENDPOINT_NUMBER}]}";
      fi            
    else
      # Incorrect ontology 
      echo "Cannot provide endpoint ${ENDPOINT_NUMBER} as incorrect ontology given: ${ONTOP_ONTOLOGY_FILE[${ENDPOINT_NUMBER}]}";
    fi            
  else
    # Incorrect port number
    echo "Cannot provide endpoint ${ENDPOINT_NUMBER} as incorrect port number given: ${ONTOP_PORT[${ENDPOINT_NUMBER}]}";
  fi
done

