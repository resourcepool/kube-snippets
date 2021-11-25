#!/bin/bash

### Increments the version of a subchart
## $1: type of increment: release, snapshot

previous_version=$(echo "$(cat Chart.yaml)" | grep "version:" | awk '{print $2}')
next_version=$(./increment_version.sh $previous_version $1)
echo "Incrementing Main Helm chart from $previous_version to $next_version"
sed -i "s/^version:.*$/version: $next_version/" ./Chart.yaml
sed -i "s/^appVersion:.*$/appVersion: $1/" ./Chart.yaml
