#!/bin/bash

### Increments the version of multiple subcharts
## $1: target subcharts path:version, comma-separated. Ex: charts/subchart1:1.0.0,charts/subchart2:0.2.0
## $2: type of increment: release, snapshot

echo "Args are : {$1 $2}"

set -f
subcharts=(${1//,/ })
for i in "${subcharts[@]}"; do
  echo "Found subchart $i"
  # process "$i"
  subchart=(${i//:/ })
  sh increment_subchart_version.sh ${subchart[0]} ${subchart[1]} $2
done
