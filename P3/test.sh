ids=$(docker ps --format '{{.ID}}')

declare -A hostmap
for i in $ids
do
    name=$(docker exec -i $i hostname)
    hostmap[$name]=$i    
done

docker exec -i ${hostmap[$1]} sh << EOF
vtysh << INNER
do sh ip route
do sh bgp summary
do sh bgp l2vpn evpn
INNER
EOF
