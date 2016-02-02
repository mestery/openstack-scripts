===================
 OVN Scale Testing
===================

These scripts will let you execute OVN scale testing around networks, subnets,
ports, and routers. To use them, do the following:

Create the ovntenant
--------------------

The first thing to do is create the "ovntenant", which will be used by all the
below scripts:

* Login to your cloud as admin, and run the "tenant.sh" script. This will
  create a "ovntenant" project and user.
* Next, as admin again, run "quota.sh" to increase the default Neutron
  quota's for networks, routers, ports and subnets for the "ovntenant"
  user.

You "ovntenant" is now ready to use.

scale.sh
--------

The "scale.sh" script is meant to create two private networks, each with it's
own subnet, connected by a router. It does this 1200 times to give you 2400
networks, 2400 subnets, 2400 ports, and 1200 routers. To use this, run the
following:

* As the "ovntenant" user, run "scale.sh create" to deploy pairs of networks
  with routers. This defaults to 1200 of these pairs, so 2400 networks/subnets,
  4800 ports, and 1200 routers.

create-routers.sh
-----------------

The script "create-routers.sh" will create 4000 routers spread across 200 shared
networks. To use this, do the following:

* As the "ovntenant" user, run the "create-routers.sh" script.

provider-scale.sh
-----------------

The script "provider-scale.sh" is meant to scale a large number of ports on a
single provider network. It creates a provider network with a /16 subnet and
then creates 10000 ports. To use this, do the following:

* As the "ovntenant" user, run the "provider-scale.sh" script.
