#!/bin/bash




simulation_id=$2
index_workstation=$1
last_byte=$((index_workstation+100))
addr_ipv4=192.168.2${simulation_id}.${last_byte}
addr_ipv6=2001:660:6602:01${simulation_id}2::${last_byte}
addr_gateway=192.168.2${simulation_id}.20



sudo cp $PWD/entites/WS/configuration_routes.sh $PWD/entites/WS/WS1/configuration_routes_${simulation_id}


sudo sed -i 's+$addr_gateway+'${addr_gateway}'+g' $PWD/entites/WS/WS1/configuration_routes_${simulation_id}

docker create -it --net lan-gw1-${simulation_id} --ip $addr_ipv4 --ip6 $addr_ipv6 --privileged --hostname server-gw1-${index_workstation}-${simulation_id} --name server-gw1-${index_workstation}-${simulation_id} -v $PWD/entites/WS/WS1/configuration_routes_${simulation_id}:/configuration_routes opensand-http-server
docker start server-gw1-${index_workstation}-${simulation_id}
docker exec server-gw1-${index_workstation}-${simulation_id} "/configuration_routes"
