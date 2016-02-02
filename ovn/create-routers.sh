NUM_ROUTERS=4000
NUM_ROUTERS_PER_SHRARED_NETWORK=200
MAX_NET_ID=`echo "($NUM_ROUTERS / $NUM_ROUTERS_PER_SHRARED_NETWORK) - 1" | bc`

for i in `seq 0 $MAX_NET_ID`; do
    neutron net-create TEST-shared-$i
    neutron subnet-create --name TEST-shared-$i TEST-shared-$i 192.168.$i.0/24
    seq 0 `echo $NUM_ROUTERS_PER_SHRARED_NETWORK - 1 | bc` | xargs -n 1 -P 5 sh _create-private.sh $i
done
