#!/bin/bash

# NOTE: The 5 below needs to match PER_RUN in scale.sh
n=`echo $1 \* 5 + $2 | bc`
#echo "Destroy N is $n"
neutron router-interface-delete ovnrouter-$n subnet=ovnsubnet-b-$n
neutron router-interface-delete  ovnrouter-$n subnet=ovnsubnet-a-$n
neutron router-delete ovnrouter-$n
neutron net-delete ovnnet-a-$n
neutron net-delete ovnnet-b-$n
