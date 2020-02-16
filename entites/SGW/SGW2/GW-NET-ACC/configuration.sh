#!/bin/bash

simulation_id=$1
sgw_sat_addr=192.168.1${simulation_id}.27
sgw_interco_addr=192.168.9${simulation_id}.27
sgw_lan_addr=192.168.3${simulation_id}.20
sgw_lan_ipv6_addr=2001:660:6602:01${simulation_id}3::2

sudo cp /home/neuaa/ProjetLong/simulation/opensand-docker/entites/SGW/SGW2/GW-NET-ACC/daemonbck.conf /home/neuaa/ProjetLong/simulation/opensand-docker/entites/SGW/SGW2/GW-NET-ACC/daemonbck${simulation_id}.conf


sudo sed -i 's+$interconnect_ipv4+'${sgw_interco_addr}'+g' /home/neuaa/ProjetLong/simulation/opensand-docker/entites/SGW/SGW2/GW-NET-ACC/daemonbck${simulation_id}.conf

sudo sed -i 's+$lan_ipv4+'${sgw_lan_addr}'/24+g' /home/neuaa/ProjetLong/simulation/opensand-docker/entites/SGW/SGW2/GW-NET-ACC/daemonbck${simulation_id}.conf

sudo sed -i 's+$lan_ipv6+'${sgw_lan_ipv6_addr}'/64+g' /home/neuaa/ProjetLong/simulation/opensand-docker/entites/SGW/SGW2/GW-NET-ACC/daemonbck${simulation_id}.conf


gw_id=5
echo >> /home/neuaa/ProjetLong/simulation/opensand-docker/output
echo "--------------------------------" >> /home/neuaa/ProjetLong/simulation/opensand-docker/output
echo >> /home/neuaa/ProjetLong/simulation/opensand-docker/output
echo "	- split satellite network access gateway 2 - ${gw_id}" >> /home/neuaa/ProjetLong/simulation/opensand-docker/output
echo "  - SAT_INTERFACE: ${sgw_sat_addr}" >> /home/neuaa/ProjetLong/simulation/opensand-docker/output
echo "  - INTERCO_INTERFACE: ${sgw_interco_addr}" >> /home/neuaa/ProjetLong/simulation/opensand-docker/output
echo "  - LAN_INTERFACE: ${sgw_lan_addr}" >> /home/neuaa/ProjetLong/simulation/opensand-docker/output


docker create -it --privileged -v /home/neuaa/ProjetLong/simulation/opensand-docker/entites/SGW/SGW2/GW-NET-ACC/daemonbck${simulation_id}.conf:/etc/opensand/daemonbck.conf --net opensand-network-${simulation_id} --ip $sgw_sat_addr --hostname gw2-net-acc-${simulation_id} --name gw2-net-acc-${simulation_id} opensand-daemon
docker network connect --ip $sgw_lan_addr --ip6 ${sgw_lan_ipv6_addr} lan-gw2-${simulation_id} gw2-net-acc-${simulation_id}
docker network connect --ip $sgw_interco_addr opensand-gw-network-${simulation_id} gw2-net-acc-${simulation_id}
docker start gw2-net-acc-${simulation_id}
docker exec gw2-net-acc-${simulation_id} "/script"