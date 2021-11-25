#!/bin/bash

### Increments the part of the string
## $1: version itself
## $2: type of increment: release equivalents to a minor increment ($inc=1), snapshot is a patch increment ($inc=2)

# number of part: 0 – major, 1 – minor, 2 – patch

increment_version() {
  local delimiter=.
  local array=($(echo "$1" | tr $delimiter '\n'))
  array[$2]=$((array[$2]+1))
  if [ $2 -lt 2 ]; then array[2]=0; fi
  if [ $2 -lt 1 ]; then array[1]=0; fi
  echo $(local IFS=$delimiter ; echo "${array[*]}")
}

inc=2
if [ "$2" == "release" ]; then
    inc=1
fi
increment_version $1 $inc
