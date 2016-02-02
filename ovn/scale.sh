#!/bin/bash

MAX_NETS=1200
NETS_PER_RUN=5
MAX_RUNS=`echo "($MAX_NETS / $NETS_PER_RUN) - 1" | bc`

if [ "$1" == "create" ] ; then
    echo "Building scale setup"

    for i in `seq 0 $MAX_RUNS`; do
        seq 0 `echo $NETS_PER_RUN - 1 | bc` | xargs -n 1 -P 5 bash _scale-create.sh $i
    done
elif [ "$1" == "destroy" ] ; then
    echo "Destroying scale setup"

    for i in `seq 0 $MAX_RUNS`; do
        seq 0 `echo $NETS_PER_RUN - 1 | bc` | xargs -n 1 -P 5 bash _scale-destroy.sh $i
    done
else
  echo "Usage: scale.sh <create | destroy>"
fi
