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

# advsvc role and user
AS=advsvc
ASUSER=suser

# Test user
KM=km

# Second test user
TU=tuser

# Create the advsvc role
keystone role-create --name $AS

# Get the advsvc role ID
ASROLEID=$(keystone role-get admin |grep id | cut -d '|' -f 3)

# Create the km tenant
keystone tenant-create --name $KM

# Get the km tenant ID
KMTENANTID=$(keystone tenant-list | grep $KM | cut -d '|' -f 2)

# Create the km user
keystone user-create --name $KM --tenant $KMTENANTID --enabled true --pass admin

# Create the tuser tenant
keystone tenant-create --name $TU

# Get the tuser tenant ID
TUTENANTID=$(keystone tenant-list | grep $TU | cut -d '|' -f 2)

# Create the tuser user
keystone user-create --name $TU --tenant $TUTENANTID --enabled true --pass admin

# Create the service tenant
keystone tenant-create --name $ASUSER

# Get the advsvc tenant ID
ADVSVCTENANTID=$(keystone tenant-list | grep $ASUSER | cut -d '|' -f 2)

# Create the service user
keystone user-create --name $ASUSER --tenant $KMTENANTID --enabled true --pass admin

# Get the service tenant ID
SUSERTENANTID=$(keystone tenant-list | grep $ASUSER | cut -d '|' -f 2)

# Add the role to the service user
keystone user-role-add --user $ASUSER --role $ASROLEID --tenant $SUSERTENANTID
