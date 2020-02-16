#!/bin/bash

simulation_id=$1
st_sat_addr=192.168.1${simulation_id}.80
st_lan_addr=192.168.8${simulation_id}.80
st_lan_ipv6_addr=2001:660:6602:01${simulation_id}8::2

sudo cp /home/neuaa/ProjetLong/simulation/opensand-docker/entites/ST/ST5/daemonbck.conf /home/neuaa/ProjetLong/simulation/opensand-docker/entites/ST/ST5/daemonbck${simulation_id}.conf


sudo sed -i 's+$emu_ipv4+'${st_sat_addr}'/24+g' /home/neuaa/ProjetLong/simulation/opensand-docker/entites/ST/ST5/daemonbck${simulation_id}.conf

sudo sed -i 's+$lan_ipv4+'${st_lan_addr}'/24+g' /home/neuaa/ProjetLong/simulation/opensand-docker/entites/ST/ST5/daemonbck${simulation_id}.conf

sudo sed -i 's+$lan_ipv6+'${st_lan_ipv6_addr}'/64+g' /home/neuaa/ProjetLong/simulation/opensand-docker/entites/ST/ST5/daemonbck${simulation_id}.conf


st_id=10
echo >> /home/neuaa/ProjetLong/simulation/opensand-docker/output
echo "--------------------------------" >> /home/neuaa/ProjetLong/simulation/opensand-docker/output
echo >> /home/neuaa/ProjetLong/simulation/opensand-docker/output
echo "- satellite terminal 1 - ${st_id}" >> /home/neuaa/ProjetLong/simulation/opensand-docker/output
echo "  - SAT_INTERFACE: ${st_sat_addr}" >> /home/neuaa/ProjetLong/simulation/opensand-docker/output
echo "  - LAN_INTERFACE: ${st_lan_addr}" >> /home/neuaa/ProjetLong/simulation/opensand-docker/output



docker create -it --privileged -v /home/neuaa/ProjetLong/simulation/opensand-docker/entites/ST/ST5/daemonbck${simulation_id}.conf:/etc/opensand/daemonbck.conf --net opensand-network-${simulation_id} --ip $st_sat_addr --hostname st5-${simulation_id} --name st5-${simulation_id} opensand-daemon
docker network connect --ip $st_lan_addr --ip6 ${st_lan_ipv6_addr} lan-st5-${simulation_id} st5-${simulation_id}
docker start st5-${simulation_id}
docker exec st5-${simulation_id} "/script"
