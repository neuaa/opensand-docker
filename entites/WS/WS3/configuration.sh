#!/bin/bash

simulation_id=$2
index_workstation=$1
last_byte=$((index_workstation+100))
addr_ipv4=192.168.4${simulation_id}.${last_byte}
addr_ipv6=2001:660:6602:01${simulation_id}4::${last_byte}
addr_gateway=192.168.4${simulation_id}.40



sudo cp /home/neuaa/ProjetLong/simulation/opensand-docker/entites/WS/configuration_routes.sh /home/neuaa/ProjetLong/simulation/opensand-docker/entites/WS/WS3/configuration_routes_${simulation_id}


sudo sed -i 's+$addr_gateway+'${addr_gateway}'+g' /home/neuaa/ProjetLong/simulation/opensand-docker/entites/WS/WS3/configuration_routes_${simulation_id}


docker create -it --net lan-st1-${simulation_id} --ip $addr_ipv4 --ip6 $addr_ipv6 --privileged --hostname ws-st1-${index_workstation}-${simulation_id} --name ws-st1-${index_workstation}-${simulation_id} -v /home/neuaa/ProjetLong/simulation/opensand-docker/entites/WS/WS3/configuration_routes_${simulation_id}:/configuration_routes opensand-ws
docker start ws-st1-${index_workstation}-${simulation_id}
docker exec ws-st1-${index_workstation}-${simulation_id} "/configuration_routes"


