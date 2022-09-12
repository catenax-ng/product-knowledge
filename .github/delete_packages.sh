#/bin/sh

#
# Sample script to delete particular versions of packages
# in a particular repo
# See copyright notice in the top folder
# See authors file in the top folder
# See license file in the top folder
#

ORGA=catenax
PACKAGE_TYPE=maven
REPOSITORY=ka-product-edc

TO_DELETE=($(curl --location --request GET 'https://api.github.com/orgs/'${ORGA}'/packages?per_page=300&package_type='${PACKAGE_TYPE} \
--header 'Authorization: Bearer '${GITHUB_TOKEN} | jq --raw-output '.[] | select(.repository.name=="'${REPOSITORY}'") | .name'))

for (( i = 1; i <= ${#TO_DELETE}; i++ )) do
    echo About to delete package ${TO_DELETE[i]};
    curl --location --request DELETE 'https://api.github.com/orgs/'${ORGA}'/packages/'${PACKAGE_TYPE}'/'${TO_DELETE[i]} \
--header 'Authorization: Bearer '${GITHUB_TOKEN}';
done
