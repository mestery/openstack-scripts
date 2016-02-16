Kyle's OpenStack Scripts
========================

This repository contains scripts I use for OpenStack development and testing.

How to test changes in local.conf with devstack
-----------------------------------------------

Add something like the following:

```
NEUTRON_REPO=https://review.openstack.org/p/openstack/neutron
NEUTRON_BRANCH=refs/changes/39/273439/10
git fetch https://mestery@review.openstack.org/a/openstack/python-neutronclient refs/changes/42/272842/12 && git checkout FETCH_HEAD
NEUTRONCLIENT_REPO=https://review.openstack.org/p/openstack/python-neutronclient
NEUTRONCLIENT_BRANCH=refs/changes/42/272842/12
LIBS_FROM_GIT=python-neutronclient
```
