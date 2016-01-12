#!/bin/bash

COUNT=1200

if [ "$1" == "build" ] ; then
  echo "Building scale setup"

  while [ "$COUNT" -gt "0" ] ; do
    neutron net-create ovnnet-a-$COUNT
    neutron net-create ovnnet-b-$COUNT
    neutron subnet-create --name ovnsubnet-a-$COUNT ovnnet-a-$COUNT 10.10.10.0/24
    neutron subnet-create --name ovnsubnet-b-$COUNT ovnnet-b-$COUNT 10.20.20.0/24
    neutron router-create ovnrouter-$COUNT
    neutron router-interface-add ovnrouter-$COUNT subnet=ovnsubnet-a-$COUNT
    neutron router-interface-add ovnrouter-$COUNT subnet=ovnsubnet-b-$COUNT
    COUNT=$((COUNT-1))
  done
elif [ "$1" == "destroy" ] ; then
  echo "Destroying scale setup"

  while [ "$COUNT" -gt "0" ] ; do
    neutron router-interface-delete ovnrouter-$COUNT subnet=ovnsubnet-b-$COUNT
    neutron router-interface-delete  ovnrouter-$COUNT subnet=ovnsubnet-a-$COUNT
    neutron router-delete ovnrouter-$COUNT
    neutron net-delete ovnnet-a-$COUNT
    neutron net-delete ovnnet-b-$COUNT
    COUNT=$((COUNT-1))
  done
else
  echo "Usage: scale.sh <build | destroy>"
fi

