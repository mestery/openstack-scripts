#!/bin/bash

MAX_PORTS=1000
PORTS_PER_RUN=5
MAX_RUNS=`echo "($MAX_PORTS / $PORTS_PER_RUN) - 1" | bc`

if [ "$1" == "create" ]; then
    neutron net-create port-test
    neutron subnet-create --name port-test port-test 10.10.0.0/16

    for i in `seq 0 $MAX_RUNS`; do
        seq 0 `echo $PORTS_PER_RUN - 1 | bc` | xargs -n 1 -P 5 bash _port-scale-create.sh $i
    done
elif [ "$1" == "destroy" ]; then
    for i in `seq 0 $MAX_RUNS`; do
        seq 0 `echo $PORTS_PER_RUN - 1 | bc` | xargs -n 1 -P 5 bash _port-scale-destroy.sh $i
    done

    neutron subnet-delete port-test
    neutron net-delete port-test
else
    echo "Usage: port-scale.sh <create | destroy>"
fi
