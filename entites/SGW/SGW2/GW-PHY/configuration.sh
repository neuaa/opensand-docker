#!/bin/bash

simulation_id=$1

sgw_sat_ip=192.168.1${simulation_id}.25
sgw_interco_ip=192.168.9${simulation_id}.25

sudo cp $PWD/entites/SGW/SGW2/GW-PHY/daemonbck.conf $PWD/entites/SGW/SGW2/GW-PHY/daemonbck${simulation_id}.conf

sudo sed -i 's+$emu_ipv4+'${sgw_sat_ip}'/24+g' $PWD/entites/SGW/SGW2/GW-PHY/daemonbck${simulation_id}.conf

sudo sed -i 's+$interconnect_ipv4+'${sgw_interco_ip}'+g' $PWD/entites/SGW/SGW2/GW-PHY/daemonbck${simulation_id}.conf

gw_id=5
echo >> $PWD/output
echo "--------------------------------" >> $PWD/output
echo >> $PWD/output
echo "- split satellite physical gateway 2 - ${gw_id}" >> $PWD/output
echo "  - SAT_INTERFACE: ${sgw_sat_ip}" >> $PWD/output
echo "  - INTERCO_INTERFACE: ${sgw_interco_ip}" >> $PWD/output

docker create -it --privileged -v $PWD/entites/SGW/SGW2/GW-PHY/daemonbck${simulation_id}.conf:/etc/opensand/daemonbck.conf --net opensand-network-${simulation_id} --ip $sgw_sat_ip --hostname sgw2-phy-${simulation_id} --name sgw2-phy-${simulation_id} opensand-daemon
docker network connect --ip $sgw_interco_ip opensand-gw-network-${simulation_id} sgw2-phy-${simulation_id}
docker start sgw2-phy-${simulation_id}
docker exec sgw2-phy-${simulation_id} "/start-daemon.sh"
