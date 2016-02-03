#!/bin/bash

PROJECTID=$(openstack project list | grep ovntenant | cut -d " " -f 2)

neutron quota-update --tenant_id $PROJECTID --network 10000
neutron quota-update --tenant_id $PROJECTID --router 5000
neutron quota-update --tenant_id $PROJECTID --port 20000
neutron quota-update --tenant_id $PROJECTID --subnet 10000
openstack flavor create --ram 64 --disk 0 --vcpus 1 --id 27 ovntenant

# Add a SG rule to allow ping
neutron security-group-rule-create --direction ingress --protocol icmp default

OVN_TENANT=$(openstack project show -f value -c id ovntenant)
nova quota-update --instances 50000 --cores 1000 --ram 1024000 $OVN_TENANT
nova quota-show --tenant $OVN_TENANT
