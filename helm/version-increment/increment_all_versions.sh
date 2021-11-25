#!/bin/bash

### Increments the version of all charts
## $1: type of increment: release, snapshot
for d in charts/*/ ; do
    app_version=$(echo "$(cat ./${d}/Chart.yaml)" | grep "appVersion:" | awk '{ print $2 }')
    bash increment_subchart_version.sh $d $app_version $1
done
bash increment_mainchart_version.sh $1
