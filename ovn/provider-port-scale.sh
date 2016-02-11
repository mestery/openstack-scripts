#!/bin/bash

START_PORTS=${START_PORTS:-0}
MAX_PORTS=${MAX_PORTS:-1000}
PORTS_PER_RUN=5
START=`echo "($START_PORTS / $PORTS_PER_RUN)" | bc`
MAX_RUNS=`echo "($MAX_PORTS / $PORTS_PER_RUN) - 1" | bc`

if [ "$1" == "create" ]; then
    for i in `seq $START $MAX_RUNS`; do
        seq 0 `echo $PORTS_PER_RUN - 1 | bc` | xargs -n 1 -P 5 bash _provider-port-scale-create.sh $i
    done
elif [ "$1" == "destroy" ]; then
    for i in `seq $START $MAX_RUNS`; do
        seq 0 `echo $PORTS_PER_RUN - 1 | bc` | xargs -n 1 -P 5 bash _provider-port-scale-destroy.sh $i
    done
else
    echo "Usage: provider-port-scale.sh <create | destroy>"
fi
