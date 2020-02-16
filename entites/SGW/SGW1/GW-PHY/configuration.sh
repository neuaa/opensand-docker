#!/bin/bash

simulation_id=$1
sgw_sat_ip=192.168.1${simulation_id}.20
sgw_interco_ip=192.168.9${simulation_id}.20


sudo cp /home/neuaa/ProjetLong/simulation/opensand-docker/entites/SGW/SGW1/GW-PHY/daemonbck.conf /home/neuaa/ProjetLong/simulation/opensand-docker/entites/SGW/SGW1/GW-PHY/daemonbck${simulation_id}.conf

sudo sed -i 's+$emu_ipv4+'${sgw_sat_ip}'/24+g' /home/neuaa/ProjetLong/simulation/opensand-docker/entites/SGW/SGW1/GW-PHY/daemonbck${simulation_id}.conf

sudo sed -i 's+$interconnect_ipv4+'${sgw_interco_ip}'+g' /home/neuaa/ProjetLong/simulation/opensand-docker/entites/SGW/SGW1/GW-PHY/daemonbck${simulation_id}.conf




gw_id=4
echo >> /home/neuaa/ProjetLong/simulation/opensand-docker/output
echo "--------------------------------" >> /home/neuaa/ProjetLong/simulation/opensand-docker/output
echo >> /home/neuaa/ProjetLong/simulation/opensand-docker/output
echo "	- split satellite physical gateway 1 - ${gw_id}" >> /home/neuaa/ProjetLong/simulation/opensand-docker/output
echo "  - SAT_INTERFACE: ${sgw_sat_ip}" >> /home/neuaa/ProjetLong/simulation/opensand-docker/output
echo "  - INTERCO_INTERFACE: ${sgw_interco_ip}" >> /home/neuaa/ProjetLong/simulation/opensand-docker/output



docker create -it --privileged -v /home/neuaa/ProjetLong/simulation/opensand-docker/entites/SGW/SGW1/GW-PHY/daemonbck${simulation_id}.conf:/etc/opensand/daemonbck.conf --net opensand-network-${simulation_id} --ip $sgw_sat_ip --hostname gw1-phy-${simulation_id} --name gw1-phy-${simulation_id} opensand-daemon
docker network connect --ip $sgw_interco_ip opensand-gw-network-${simulation_id} gw1-phy-${simulation_id}
docker start gw1-phy-${simulation_id}
docker exec gw1-phy-${simulation_id} "/script"


