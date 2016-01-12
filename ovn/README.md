===================
 OVN Scale Testing
===================

These scripts will let you execute OVN scale testing around networks, subnets,
ports, and routers. To use them, do the following:

* Create a cloud! Make sure it's using OVN as the Neutron plugin, and make
  sure to enable L3 functionality in OVN.
* Login to your cloud as admin, and run the "tenant.sh" script. This will
  create a "ovntenant" project and user.
* Next, as admin again, run "quota.sh" to increase the default Neutron
  quota's for networks, routers, ports and subnets for the "ovntenant"
  user.
* Lastly, run "scale.sh build" to deploy pairs of networks with routers.
  This defaults to 1200 of these pairs, so 2400 networks/subnets, 4800
  ports, and 1200 routers.
* Profit!
