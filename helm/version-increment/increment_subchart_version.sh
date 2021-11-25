#!/bin/bash

### Increments the version of a subchart
## $1: target subchart path ex: charts/mychart1
## $2: target app version of subchart
## $3: type of increment: release, snapshot

previous_version=$(echo "$(cat ./$1/Chart.yaml)" | grep "version:" | awk '{ print $2 }')
next_version=$(./increment_version.sh $previous_version $3)
subchart_name=$(echo $1 | cut -d'/' -f 2)

if [ "$3" == "release" ]; then
  echo "Incrementing Helm subchart $1 with app version $2 from $previous_version to $next_version"
  sed -i "s/^version:.*$/version: $next_version/" ./$1/Chart.yaml
  sed -i "s/^appVersion:.*$/appVersion: $2/" ./$1/Chart.yaml
  echo "Updating values-production.yml for $subchart_name with app version $2"
  yq e -i ".${subchart_name}.image.tag = \"$2\"" values-production.yaml
  yq e -i ".${subchart_name}.image.tag = \"$2\"" values-staging.yaml
else
  echo "Updating values-staging.yml for $subchart_name with app version $2"
  yq e -i ".${subchart_name}.image.tag = \"$2\"" values-staging.yaml
fi


