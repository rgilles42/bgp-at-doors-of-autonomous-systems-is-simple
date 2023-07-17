#!/bin/bash
if [[ $1 == 'multi' ]]; then
	ip link add name vxlan10 type vxlan id 10 dev eth0 \
		group 239.1.1.1 dstport 4789
	if [[ $(hostname | cut -d '-' -f 2) == 1 ]]; then
		ip addr add 10.3.1.1/24 dev vxlan10
	else
		ip addr add 10.3.1.2/24 dev vxlan10
	fi
else
	if [[ $(hostname | cut -d '-' -f 2) == 1 ]]; then
		ip link add name vxlan10 type vxlan id 10 dev eth0 \
			remote 10.1.1.2 local 10.1.1.1 dstport 4789
		ip addr add 10.3.1.1/24 dev vxlan10
	else 
		ip link add name vxlan10 type vxlan id 10 dev eth0 \
			remote 10.1.1.1 local 10.1.1.2 dstport 4789
		ip addr add 10.3.1.2/24 dev vxlan10
	fi
fi

brctl addbr br0
brctl addif br0 eth1
brctl addif br0 vxlan10

ip link set dev br0 up
ip link set dev vxlan10 up