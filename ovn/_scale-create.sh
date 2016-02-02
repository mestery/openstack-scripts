#!/bin/bash

# NOTE: The 5 below needs to match PER_RUN in scale.sh
n=`echo $1 \* 5 + $2 | bc`
#echo "Create N is $n"
neutron net-create ovnnet-a-$n
neutron net-create ovnnet-b-$n
neutron subnet-create --name ovnsubnet-a-$n ovnnet-a-$n 10.$1.$2.0/24
neutron subnet-create --name ovnsubnet-b-$n ovnnet-b-$n 10.$2.$1.0/24
neutron router-create ovnrouter-$n
neutron router-interface-add ovnrouter-$n subnet=ovnsubnet-a-$n
neutron router-interface-add ovnrouter-$n subnet=ovnsubnet-b-$n
