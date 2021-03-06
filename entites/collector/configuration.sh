#!/bin/bash

simulation_id=$1
addr_ipv4=192.168.1${simulation_id}.11


collector_id=2
echo >> $PWD/output #output
echo "--------------------------------" >> $PWD/output 
echo >> $PWD/output 
echo "- collector - ${collector_id}" >> $PWD/output 
echo "  - SAT_INTERFACE: ${addr_ipv4}" >> $PWD/output 



docker create -it --privileged --net opensand-network-${simulation_id} --hostname collector-${simulation_id} --name collector-${simulation_id} --ip $addr_ipv4 opensand-collector
docker start collector-${simulation_id}
docker exec collector-${simulation_id} "/start-collector.sh"


