# opensand-docker

**opensand-docker is a container-based tool that allows deploying an emulated satellite architecture into Docker containers.**

As the name of the projet suggests, it uses OpenSAND, an open source emulator developped by CNES (National Centre for Space Studies), Thales Alenia Space and Vivéris Technologies companies. For more informations, https://opensand.org/content/home.php

The orchestrator can be seen as a GUI server who communicates with running containers. Both run on local machine. Container are OpenSAND entites(collector, gateway, satellite terminals) or independant workstations (or server).

Here are the requirements for using the orchestrator and starting containers :

        - ubuntu 16.04 or 18.04 (I personnaly advice using ubuntu 16.04). As OpenSAND can configure your local network configuration, using a virtual machine is preferred.
        
        -  docker packages (please refer to the official documentation https://docs.docker.com/install/linux/docker-ce/ubuntu/)
        
        - opensand and opensand-manager packages (please refer to the official documentation https://opensand.org/content/get.php). Opensand-Manager will be required in order to start the emulation.
        
        - Make sure 192.168.{1..9}y.0/24 addresses are free on your workstation. Those adresses will be used by Docker for the emulation network.
        
        - First launching could be a little long (a few minutes) as you need to build opensand images.
        
        -  Using the sudo rights
        
Here are some commands to deploy the architecture :

**Print the help :**

    sudo ./opensand-docker -h 
  
 **Deploy a simple architecture.** Note that it indirectly create opensand docker images and networks, recquired for the deployment.
 The simple architecture includes a collector, a satellite, a satellite terminal and a client in each local network in each terrestrial entity (GW and ST)
  
    sudo ./opensand-docker --simulate
  
**Deploy a more detailed architecture**, here with 1 gateway, 3 satellite terminals and 2 clients in each local network
  
    sudo ./opensand-docker --simulate -i 2 -gw 1 -st 3 -c 2 
  
**More generally :**

    sudo ./opensand-docker --simulate -i $simulation_id -gw $nb_gw -st $nb_st -c $nb_clients
    
  Note that you cannot deploy :
  
    - more than 2 gateways
  
    - more than 5 satellite terminals
    
    - the "simulation_id" must be between 0 and 9 included and define ip adresses of the architecture.  
    
OpenSAND offers the possibility to deploy a "split-gateway" : a gateway for physical aspect and a related gateway for network access (For more details : https://wiki.net4sat.org/doku.php?id=opensand:emulated_satcom_features:system:split_gateway:index). **To Deploy a split gateway, just replace -gw by -sgw (you can still deploy until 2 split gateways)**

**Use sand-manager GUI to start a simulation**

        sudo sand-manager -i
        
 The orchestrator automatically launch sand-manager but there could be some problems with the GUI part. In case of problem, remove the GUI, kill the sand-manager (pkill sand-manager) process and re-try the sand-manager -i command.

**While simulation running, you can modify some parameters by**
        
        - using the GUI interface (the simulation must be previously stopped)
        OR
        - using the following command : sudo ./opensand-docker --simulation-change -id ${simulation_id} -d 150 -fbw 100
        This command will set the delay to 150ms (by default 125ms) and the forward bandwidth to 100MHz (by default 50MHz)
        
**Current simulation OpenSAND entities are listed with the following command :**
         
         sudo ./opensand-docker --list-simulation

**Running containers are listed with :**

        sudo docker ps 
        
**Access to a running client with following command**
 
        sudo docker exec -it ws-$LAN_GW-$client_id-$simulation_id (use docker ps command to know exactly the name of your clients containers)
        
Note that default route is configured as its associated LAN_GW.


  **Remove the architecture with simulation id equal to $simulation_id** (i correspond to the id of the simulation, by default 0 if not precised) : 
 
    sudo ./opensand-docker --destroy -i $simulation_id
    
 **A recommended practice is to exit the manager GUI after deleting the architecture**
    
   
  
