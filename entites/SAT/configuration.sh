#!/bin/bash
simulation_id=$1
addr_ipv4=192.168.1${simulation_id}.10



sudo cp $PWD/entites/SAT/daemonbck.conf $PWD/entites/SAT/daemonbck${simulation_id}.conf

sudo sed -i 's+$emu_ipv4+'${addr_ipv4}'/24+g' $PWD/entites/SAT/daemonbck${simulation_id}.conf


sat_id=3
echo >> $PWD/output
echo "--------------------------------" >> $PWD/output 
echo >> $PWD/output
echo "- satellite - ${sat_id}" >> $PWD/output
echo "  - SAT_INTERFACE: ${addr_ipv4}" >> $PWD/output


docker create -it --privileged -v $PWD/entites/SAT/daemonbck${simulation_id}.conf:/etc/opensand/daemonbck.conf --net opensand-network-${simulation_id} --ip $addr_ipv4 --hostname sat-${simulation_id} --name sat-${simulation_id} opensand-daemon
docker start sat-${simulation_id}
docker exec sat-${simulation_id} "/start-daemon.sh"

