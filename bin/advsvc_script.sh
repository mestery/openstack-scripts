#!/bin/bash
#
# Copyright (c) 2014 Kyle Mestery
# All Rights Reserved.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.
# @author: Kyle Mestery, Cisco Systems, Inc.

#
# This is used to test keystone roles with neutron, specifically the advsvc role
# cases.
#
# For launchpad bug:
# https://launchpad.net/bugs/1331836
#

AS=advsvc
KM=km

# Create the advsvc role
keystone role-create --name $AS

# Get the advsvc role ID
ASROLEID=$(keystone role-get admin |grep id | cut -d '|' -f 3)

# Get the demo tenant ID
DEMOTENANTID=$(keystone tenant-list | grep -v _demo | grep demo | cut -d '|' -f 2)

# Add the role to the demo user
keystone user-role-add --user demo --role $ASROLEID --tenant $DEMOTENANTID

# Create the km tenant
keystone tenant-create --name $KM

# Get the km tenant ID
KMTENANTID=$(keystone tenant-list | grep km | cut -d '|' -f 2)

# Create the km user
keystone user-create --name $KM --tenant $KMTENANTID --enabled true --pass admin

