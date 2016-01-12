#!/bin/bash

openstack project create ovntenant
openstack user create --password password ovntenant
openstack role add --user ovntenant --project ovntenant anotherrole
openstack role add --user ovntenant --project ovntenant Member
