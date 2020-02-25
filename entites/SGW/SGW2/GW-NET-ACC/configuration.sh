#!/bin/bash

simulation_id=$1
sgw_sat_addr=192.168.1${simulation_id}.27
sgw_interco_addr=192.168.9${simulation_id}.27
sgw_lan_addr=192.168.3${simulation_id}.30
sgw_lan_ipv6_addr=2001:660:6602:01${simulation_id}3::2

sudo cp $PWD/entites/SGW/SGW2/GW-NET-ACC/daemonbck.conf $PWD/entites/SGW/SGW2/GW-NET-ACC/daemonbck${simulation_id}.conf


sudo sed -i 's+$interconnect_ipv4+'${sgw_interco_addr}'+g' $PWD/entites/SGW/SGW2/GW-NET-ACC/daemonbck${simulation_id}.conf

sudo sed -i 's+$lan_ipv4+'${sgw_lan_addr}'/24+g' $PWD/entites/SGW/SGW2/GW-NET-ACC/daemonbck${simulation_id}.conf

sudo sed -i 's+$lan_ipv6+'${sgw_lan_ipv6_addr}'/64+g' $PWD/entites/SGW/SGW2/GW-NET-ACC/daemonbck${simulation_id}.conf


gw_id=5
echo >> $PWD/output
echo "--------------------------------" >> $PWD/output
echo >> $PWD/output
echo "- split satellite network access gateway 2 - ${gw_id}" >> $PWD/output
echo "  - SAT_INTERFACE: ${sgw_sat_addr}" >> $PWD/output
echo "  - INTERCO_INTERFACE: ${sgw_interco_addr}" >> $PWD/output
echo "  - LAN_INTERFACE: ${sgw_lan_addr}" >> $PWD/output


docker create -it --privileged -v $PWD/entites/SGW/SGW2/GW-NET-ACC/daemonbck${simulation_id}.conf:/etc/opensand/daemonbck.conf --net opensand-network-${simulation_id} --ip $sgw_sat_addr --hostname sgw2-net-acc-${simulation_id} --name sgw2-net-acc-${simulation_id} opensand-daemon
docker network connect --ip $sgw_lan_addr --ip6 ${sgw_lan_ipv6_addr} lan-gw2-${simulation_id} sgw2-net-acc-${simulation_id}
docker network connect --ip $sgw_interco_addr opensand-gw-network-${simulation_id} sgw2-net-acc-${simulation_id}
docker start sgw2-net-acc-${simulation_id}
docker exec sgw2-net-acc-${simulation_id} "/start-daemon.sh"
