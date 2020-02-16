#!/bin/bash
simulation_id=$1
addr_ipv4=192.168.1${simulation_id}.10

sudo cp /home/neuaa/ProjetLong/simulation/opensand-docker/entites/SAT/daemonbck.conf /home/neuaa/ProjetLong/simulation/opensand-docker/entites/SAT/daemonbck${simulation_id}.conf

sudo sed -i 's+$emu_ipv4+'${addr_ipv4}'/24+g' /home/neuaa/ProjetLong/simulation/opensand-docker/entites/SAT/daemonbck${simulation_id}.conf

docker create -it --privileged -v /home/neuaa/ProjetLong/simulation/opensand-docker/entites/SAT/daemonbck${simulation_id}.conf:/etc/opensand/daemonbck.conf --net opensand-network-${simulation_id} --ip $addr_ipv4 --hostname sat-${simulation_id} --name sat-${simulation_id} opensand-daemon
docker start sat-${simulation_id}
docker exec sat-${simulation_id} "/script"

sat_id=3
echo >> output
echo "--------------------------------" >> output
echo >> output
echo "- satellite - ${sat_id}" >> output
echo "  - SAT_INTERFACE: ${addr_ipv4}" >> output
