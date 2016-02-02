#!/bin/bash

MAX_VMS=20
VMS_PER_RUN=5
MAX_RUNS=`echo "($MAX_VMS / $VMS_PER_RUN) - 1" | bc`

if [ "$1" == "create" ]; then
    # Get the ID of the cirros image
    export CIRROS=$(openstack image list|grep "cirros-0.3.4-x86_64-uec " |cut -d " " -f 2)
    # Get the ID of the provider network
    export PROVIDER=$(openstack network list | grep provider | cut -d " " -f 2)

    for i in `seq 0 $MAX_RUNS`; do
        seq 0 `echo $VMS_PER_RUN - 1 | bc` | xargs -n 1 -P 5 bash _vm-scale-create.sh $i
    done
elif [ "$1" == "destroy" ]; then
    for i in `seq 0 $MAX_RUNS`; do
        seq 0 `echo $VMS_PER_RUN - 1 | bc` | xargs -n 1 -P 5 bash _vm-scale-destroy.sh $i
    done
else
    echo "Usage: vm-scale.sh <create | destroy>"
fi
