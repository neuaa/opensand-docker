#!/bin/bash

simulation_id=$2
index_workstation=$1
last_byte=$((index_workstation+100))
addr_ipv4=192.168.4${simulation_id}.${last_byte}
addr_ipv6=2001:660:6602:01${simulation_id}4::${last_byte}
addr_gateway=192.168.4${simulation_id}.40

echo >> $PWD/output
echo "--------------------------------" >> $PWD/output
echo >> $PWD/output
echo "- client LAN ST 1" >> $PWD/output
echo "  - LAN_INTERFACE: ${addr_ipv4}" >> $PWD/output


sudo cp $PWD/entites/WS/configuration_routes.sh $PWD/entites/WS/WS3/configuration_routes_${simulation_id}


sudo sed -i 's+$addr_gateway+'${addr_gateway}'+g' $PWD/entites/WS/WS3/configuration_routes_${simulation_id}


docker create -it --net lan-st1-${simulation_id} --ip $addr_ipv4 --ip6 $addr_ipv6 --privileged --hostname ws-st1-${index_workstation}-${simulation_id} --name ws-st1-${index_workstation}-${simulation_id} -v $PWD/entites/WS/WS3/configuration_routes_${simulation_id}:/configuration_routes opensand-ws
docker start ws-st1-${index_workstation}-${simulation_id}
docker exec ws-st1-${index_workstation}-${simulation_id} "/configuration_routes"


