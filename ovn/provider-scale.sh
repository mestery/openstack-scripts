#!/bin/bash

MAX_PORTS=1000
PORTS_PER_RUN=5
MAX_RUNS=`echo "($MAX_PORTS / $PORTS_PER_RUN) - 1" | bc`

if [ "$1" == "create" ]; then
    neutron net-create provider-test
    neutron subnet-create --name provider-test provider-test 10.10.0.0/16

    for i in `seq 0 $MAX_RUNS`; do
        seq 0 `echo $PORTS_PER_RUN - 1 | bc` | xargs -n 1 -P 5 bash _provider-scale-create.sh $i
    done
elif [ "$1" == "destroy" ]; then
    for i in `seq 0 $MAX_RUNS`; do
        seq 0 `echo $PORTS_PER_RUN - 1 | bc` | xargs -n 1 -P 5 bash _provider-scale-destroy.sh $i
    done

    neutron subnet-delete provider-test
    neutron net-delete provider-test
else
    echo "Usage: provider-scale.sh <create | destroy>"
fi
