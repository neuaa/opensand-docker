# opensand-docker

This file explains how to use the project opensand-docker.

**opensand-docker is a container-based tool that allows deploying an emulated satellite architecture into Docker containers.**

As the name of the projet suggests, it uses OpenSAND, an open source emulator developped by CNES (National Centre for Space Studies), Thales Alenia Space and Vivéris Technologies companies. For more informations, https://opensand.org/content/home.php

Here are some commands to deploy the architecture :

**Print the help :**

./opensand-docker -h 
  
 **Deploy a simple architecture.** Note that it indirectly create opensand docker images and networks, recquired for the deployment.
 The simple architecture includes a collector, a satellite, a satellite terminal and a client in each local network in each terrestrial entity (GW and ST)
  
./opensand-docker --simulate
  
**Deploy a more detailed architecture**, here with 1 gateway, 3 satellite terminals and 2 clients in each local network
  
./opensand-docker -i 2 -gw 1 -st 3 -c 2 
  
**More generally :**

./opensand-docker -i $simulation_id -gw $nb_gw -st $nb_st -c $nb_clients
    
  Note that you cannot deploy :
  
    - more than 2 gateways
  
    - more than 5 satellite terminals
    
    - the "simulation_id" must be between 0 and 9 included and define ip adresses of the architecture.   
  
  
**Remove the architecture with simulation id equal to 0** (i correspond to the id of the simulation, by default 0) : 
 
 ./opensand-docker --destroy -i 0
    
   
  
