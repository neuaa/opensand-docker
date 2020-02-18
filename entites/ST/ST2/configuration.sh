#!/bin/bash

simulation_id=$1
st_sat_addr=192.168.1${simulation_id}.50
st_lan_addr=192.168.5${simulation_id}.50
st_lan_ipv6_addr=2001:660:6602:01${simulation_id}5::2

sudo cp $PWD/entites/ST/ST2/daemonbck.conf $PWD/entites/ST/ST2/daemonbck${simulation_id}.conf


sudo sed -i 's+$emu_ipv4+'${st_sat_addr}'/24+g' $PWD/entites/ST/ST2/daemonbck${simulation_id}.conf

sudo sed -i 's+$lan_ipv4+'${st_lan_addr}'/24+g' $PWD/entites/ST/ST2/daemonbck${simulation_id}.conf

sudo sed -i 's+$lan_ipv6+'${st_lan_ipv6_addr}'/64+g' $PWD/entites/ST/ST2/daemonbck${simulation_id}.conf


st_id=7
echo >> $PWD/output
echo "--------------------------------" >> $PWD/output
echo >> $PWD/output
echo "- satellite terminal 2 - ${st_id}" >> $PWD/output
echo "  - SAT_INTERFACE: ${st_sat_addr}" >> $PWD/output
echo "  - LAN_INTERFACE: ${st_lan_addr}" >> $PWD/output


docker create -it --privileged -v $PWD/entites/ST/ST2/daemonbck${simulation_id}.conf:/etc/opensand/daemonbck.conf --net opensand-network-${simulation_id} --ip $st_sat_addr --hostname st2-${simulation_id} --name st2-${simulation_id} opensand-daemon
docker network connect --ip $st_lan_addr --ip6 ${st_lan_ipv6_addr} lan-st2-${simulation_id} st2-${simulation_id}
docker start st2-${simulation_id}
docker exec st2-${simulation_id} "/start-daemon.sh"

