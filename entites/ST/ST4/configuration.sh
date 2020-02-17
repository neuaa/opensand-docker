#!/bin/bash

simulation_id=$1
st_sat_addr=192.168.1${simulation_id}.70
st_lan_addr=192.168.7${simulation_id}.70
st_lan_ipv6_addr=2001:660:6602:01${simulation_id}7::2

#sudo cp /home/neuaa/ProjetLong/simulation/opensand-docker/entites/ST/ST4/daemonbck.conf /home/neuaa/ProjetLong/simulation/opensand-docker/entites/ST/ST4/daemonbck${simulation_id}.conf
sudo cp $PWD/entites/ST/ST4/daemonbck.conf $PWD/entites/ST/ST4/daemonbck${simulation_id}.conf


#sudo sed -i 's+$emu_ipv4+'${st_sat_addr}'/24+g' /home/neuaa/ProjetLong/simulation/opensand-docker/entites/ST/ST4/daemonbck${simulation_id}.conf
sudo sed -i 's+$emu_ipv4+'${st_sat_addr}'/24+g' $PWD/entites/ST/ST4/daemonbck${simulation_id}.conf

#sudo sed -i 's+$lan_ipv4+'${st_lan_addr}'/24+g' /home/neuaa/ProjetLong/simulation/opensand-docker/entites/ST/ST4/daemonbck${simulation_id}.conf
sudo sed -i 's+$lan_ipv4+'${st_lan_addr}'/24+g' $PWD/entites/ST/ST4/daemonbck${simulation_id}.conf

#sudo sed -i 's+$lan_ipv6+'${st_lan_ipv6_addr}'/64+g' /home/neuaa/ProjetLong/simulation/opensand-docker/entites/ST/ST4/daemonbck${simulation_id}.conf
sudo sed -i 's+$lan_ipv6+'${st_lan_ipv6_addr}'/64+g' $PWD/entites/ST/ST4/daemonbck${simulation_id}.conf


st_id=9
echo >> $PWD/output
echo "--------------------------------" >> $PWD/output
echo >> $PWD/output
echo "- satellite terminal 4 - ${st_id}" >> $PWD/output
echo "  - SAT_INTERFACE: ${st_sat_addr}" >> $PWD/output
echo "  - LAN_INTERFACE: ${st_lan_addr}" >> $PWD/output



docker create -it --privileged -v $PWD/entites/ST/ST4/daemonbck${simulation_id}.conf:/etc/opensand/daemonbck.conf --net opensand-network-${simulation_id} --ip $st_sat_addr --hostname st4-${simulation_id} --name st4-${simulation_id} opensand-daemon
docker network connect --ip $st_lan_addr --ip6 ${st_lan_ipv6_addr} lan-st4-${simulation_id} st4-${simulation_id}
docker start st4-${simulation_id}
docker exec st4-${simulation_id} "/script"

