#!/bin/bash

simulation_id=$2
index_workstation=$1
last_byte=$((index_workstation+100))
addr_ipv4=192.168.8${simulation_id}.${last_byte}
addr_ipv6=2001:660:6602:01${simulation_id}8::${last_byte}
addr_gateway=192.168.8${simulation_id}.80



sudo cp /home/neuaa/ProjetLong/simulation/opensand-docker/entites/WS/configuration_routes.sh /home/neuaa/ProjetLong/simulation/opensand-docker/entites/WS/WS7/configuration_routes_${simulation_id}


sudo sed -i 's+$addr_gateway+'${addr_gateway}'+g' /home/neuaa/ProjetLong/simulation/opensand-docker/entites/WS/WS7/configuration_routes_${simulation_id}

docker create -it --net lan-st5-${simulation_id} --ip $addr_ipv4 --ip6 $addr_ipv6 --privileged --hostname ws-st5-${index_workstation}-${simulation_id} --name ws-st5-${index_workstation}-${simulation_id} -v /home/neuaa/ProjetLong/simulation/opensand-docker/entites/WS/WS7/configuration_routes_${simulation_id}:/configuration_routes opensand-ws
docker start ws-st5-${index_workstation}-${simulation_id}
docker exec ws-st5-${index_workstation}-${simulation_id} "/configuration_routes"

