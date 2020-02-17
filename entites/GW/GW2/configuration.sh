#!/bin/bash

simulation_id=$1
gw_sat_addr=192.168.1${simulation_id}.25
gw_lan_addr=192.168.3${simulation_id}.20
gw_lan_ipv6_addr=2001:660:6602:01${simulation_id}3::2

#sudo cp /home/neuaa/ProjetLong/simulation/opensand-docker/entites/GW/GW2/daemonbck.conf /home/neuaa/ProjetLong/simulation/opensand-docker/entites/GW/GW2/daemonbck${simulation_id}.conf
sudo cp $PWD/entites/GW/GW2/daemonbck.conf $PWD/entites/GW/GW2/daemonbck${simulation_id}.conf

#sudo sed -i 's+$emu_ipv4+'${gw_sat_addr}'/24+g' /home/neuaa/ProjetLong/simulation/opensand-docker/entites/GW/GW2/daemonbck${simulation_id}.conf
sudo sed -i 's+$emu_ipv4+'${gw_sat_addr}'/24+g' $PWD/entites/GW/GW2/daemonbck${simulation_id}.conf

#sudo sed -i 's+$lan_ipv4+'${gw_lan_addr}'/24+g' /home/neuaa/ProjetLong/simulation/opensand-docker/entites/GW/GW2/daemonbck${simulation_id}.conf
sudo sed -i 's+$lan_ipv4+'${gw_lan_addr}'/24+g' $PWD/entites/GW/GW2/daemonbck${simulation_id}.conf

#sudo sed -i 's+$lan_ipv6+'${gw_lan_ipv6_addr}'/64+g' /home/neuaa/ProjetLong/simulation/opensand-docker/entites/GW/GW2/daemonbck${simulation_id}.conf
sudo sed -i 's+$lan_ipv6+'${gw_lan_ipv6_addr}'/64+g' $PWD/entites/GW/GW2/daemonbck${simulation_id}.conf




gw_id=5
echo >> $PWD/output
echo "--------------------------------" >> $PWD/output
echo >> $PWD/output
echo "- satellite gateway 2 - ${gw_id}" >> $PWD/output
echo "  - SAT_INTERFACE: ${gw_sat_addr}" >> $PWD/output
echo "  - LAN_INTERFACE: ${gw_lan_addr}" >> $PWD/output


docker create -it --privileged -v $PWD/entites/GW/GW2/daemonbck${simulation_id}.conf:/etc/opensand/daemonbck.conf --net opensand-network-${simulation_id} --ip $gw_sat_addr  --hostname gw2-${simulation_id} --name gw2-${simulation_id} opensand-daemon
docker network connect --ip $gw_lan_addr --ip6 $gw_lan_ipv6_addr lan-gw2-${simulation_id} gw2-${simulation_id}
docker start gw2-${simulation_id}
docker exec gw2-${simulation_id} "/script"

