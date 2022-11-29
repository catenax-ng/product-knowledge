#!/bin/bash

#
# Setup script for druid to initialize data tasks
# See copyright notice in the top folder
# See authors file in the top folder
# See license file in the top folder
#

echo "Setup Druid Tasks"

SLEEP=60

SCRIPTS=${1}
if [ "$SCRIPTS" == "" ]; then
  SCRIPTS=/opt/druid/data/*.sql
fi

for script in $SCRIPTS;
do
  echo 'Sleeping '$SLEEP' seconds.'
  sleep $SLEEP
  echo 'About to issue '${script}' to the Druid task interface.'
  set -o noglob
  echo '{ "query":'$(tr '\n' ' ' < ${script} | jq -R -s '.' )'}' | curl -X 'POST' -H 'Content-Type:application/json' -d @- http://localhost:8888/druid/v2/sql/task
  set +o noglob
  echo
done

echo "Finished Druid Tasks"
