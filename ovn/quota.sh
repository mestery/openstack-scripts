#!/bin/bash

PROJECTID=$(openstack project list | grep ovntenant | cut -d " " -f 2)

neutron quota-update --tenant_id $PROJECTID --network 10000
neutron quota-update --tenant_id $PROJECTID --router 5000
neutron quota-update --tenant_id $PROJECTID --port 20000
neutron quota-update --tenant_id $PROJECTID --subnet 10000
openstack flavor create --ram 64 --disk 0 --vcpus 1 --id 27 ovntenant
nova quota-update --instances 50000 ovntenant
nova quota-show --tenant ovntenant
