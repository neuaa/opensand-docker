#!/bin/bash 

simulation_id=$1

for ((i=1;i<=5;i++)); do

	docker exec st${i}-${simulation_id} ip r del default
	docker exec st${i}-${simulation_id} ip r add default via 192.168.2${simulation_id}.20
	docker exec st${i}-${simulation_id} ip r add default via 192.168.3${simulation_id}.30

done
