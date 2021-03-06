#!/bin/bash

simulation_id=$2
index_workstation=$1
last_byte=$((index_workstation+100))
addr_ipv4=192.168.7${simulation_id}.${last_byte}
addr_ipv6=2001:660:6602:01${simulation_id}7::${last_byte}
addr_gateway=192.168.7${simulation_id}.70

echo >> $PWD/output
echo "--------------------------------" >> $PWD/output
echo >> $PWD/output
echo "- client LAN ST 4" >> $PWD/output
echo "  - LAN_INTERFACE: ${addr_ipv4}" >> $PWD/output


sudo cp $PWD/entites/WS/configuration_routes.sh $PWD/entites/WS/WS6/configuration_routes_${simulation_id}

sudo sed -i 's+$addr_gateway+'${addr_gateway}'+g' $PWD/entites/WS/WS6/configuration_routes_${simulation_id}

docker create -it --net lan-st4-${simulation_id} --ip $addr_ipv4 --ip6 $addr_ipv6 --privileged --hostname ws-st4-${index_workstation}-${simulation_id} --name ws-st4-${index_workstation}-${simulation_id} -v $PWD/entites/WS/WS6/configuration_routes_${simulation_id}:/configuration_routes opensand-ws
docker start ws-st4-${index_workstation}-${simulation_id}
docker exec ws-st4-${index_workstation}-${simulation_id} "/configuration_routes"

