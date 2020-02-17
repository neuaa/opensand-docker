#!/bin/bash

simulation_id=$1
st_sat_addr=192.168.1${simulation_id}.40
st_lan_addr=192.168.4${simulation_id}.40
st_lan_ipv6_addr=2001:660:6602:01${simulation_id}4::2

opensand_docker_path=./../../..


#sudo cp /home/neuaa/ProjetLong/simulation/opensand-docker/entites/ST/ST1/daemonbck.conf /home/neuaa/ProjetLong/simulation/opensand-docker/entites/ST/ST1/daemonbck${simulation_id}.conf
sudo cp $PWD/entites/ST/ST1/daemonbck.conf $PWD/entites/ST/ST1/daemonbck${simulation_id}.conf

#sudo sed -i 's+$emu_ipv4+'${st_sat_addr}'/24+g' /home/neuaa/ProjetLong/simulation/opensand-docker/entites/ST/ST1/daemonbck${simulation_id}.conf
sudo sed -i 's+$emu_ipv4+'${st_sat_addr}'/24+g' $PWD/entites/ST/ST1/daemonbck${simulation_id}.conf

#sudo sed -i 's+$lan_ipv4+'${st_lan_addr}'/24+g' /home/neuaa/ProjetLong/simulation/opensand-docker/entites/ST/ST1/daemonbck${simulation_id}.conf
sudo sed -i 's+$lan_ipv4+'${st_lan_addr}'/24+g' $PWD/entites/ST/ST1/daemonbck${simulation_id}.conf

#sudo sed -i 's+$lan_ipv6+'${st_lan_ipv6_addr}'/64+g' /home/neuaa/ProjetLong/simulation/opensand-docker/entites/ST/ST1/daemonbck${simulation_id}.conf
sudo sed -i 's+$lan_ipv6+'${st_lan_ipv6_addr}'/64+g' $PWD/entites/ST/ST1/daemonbck${simulation_id}.conf


st_id=6
echo >> $opensand_docker_path/output
echo "--------------------------------" >> $PWD/output
echo >> $opensand_docker_path/output
echo "- satellite terminal 1 - ${st_id}" >> $PWD/output
echo "  - SAT_INTERFACE: ${st_sat_addr}" >> $PWD/output
echo "  - LAN_INTERFACE: ${st_lan_addr}" >> $PWD/output


docker create -it --privileged -v $PWD/entites/ST/ST1/daemonbck${simulation_id}.conf:/etc/opensand/daemonbck.conf --net opensand-network-${simulation_id} --ip $st_sat_addr --hostname st1-${simulation_id} --name st1-${simulation_id} opensand-daemon-2
docker network connect --ip $st_lan_addr --ip6 ${st_lan_ipv6_addr} lan-st1-${simulation_id} st1-${simulation_id}
docker start st1-${simulation_id}
docker exec st1-${simulation_id} "/start-daemon.sh"

