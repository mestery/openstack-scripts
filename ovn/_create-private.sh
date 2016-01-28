n=`echo $1 \* 200 + $2 | bc`
neutron net-create TEST-private-$n
neutron subnet-create --name TEST-private-$n TEST-private-$n 10.$1.$2.0/24
neutron router-create TEST-router-$n
neutron router-interface-add TEST-router-$n TEST-private-$n
neutron port-create --name TEST-shared-$1-$2 TEST-shared-$1
neutron router-interface-add TEST-router-$n port=TEST-shared-$1-$2
