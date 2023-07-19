#!/bin/bash
router_id=$(hostname | cut -d '-' -f 2)
if [[ $1 == 'multi' ]]; then
	ip link add name vxlan10 type vxlan id 10 dev eth0 \
		group 239.1.1.1 dstport 4789
else
	ip link add name vxlan10 type vxlan id 10 dev eth0 \
		local 10.1.1.$router_id remote 10.1.1.$((3-$router_id)) dstport 4789
fi
ip addr add 10.3.1.$router_id/24 dev vxlan10
brctl addbr br0
brctl addif br0 eth1
brctl addif br0 vxlan10

ip link set dev br0 up
ip link set dev vxlan10 up