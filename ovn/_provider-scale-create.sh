#!/bin/bash

# NOTE: The value "5" below needs to match the PORTS_PER_RUN variable
#       in provider-scale.sh
n=`echo $1 \* 5 + $2 | bc`
#echo "Create n is $n"
neutron port-create --name provider-port-$n provider-test
