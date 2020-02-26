# opensand-docker

**opensand-docker is a container-based tool that allows deploying an emulated satellite architecture into Docker containers.**

As the name of the projet suggests, it uses OpenSAND, an open source emulator developped by CNES (National Centre for Space Studies), Thales Alenia Space and Vivéris Technologies companies. For more informations, https://opensand.org/content/home.php

The orchestrator can be seen as a GUI server who communicates with running containers. Both run on local machine. Container are OpenSAND entites(collector, gateway, satellite terminals) or independant workstations (or server).

Here is an exemple of architecture locally deployed. Note that two kind of gateways exists : a classic GW (here GW0), and a split GW (divided into GW-PHY and GW-NET-ACC components). 

![architecture-globale](https://zupimages.net/up/20/09/ax2d.png)

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
    
 ![simple architecture](https://zupimages.net/up/20/09/3d7j.png)
  
**Deploy a more detailed architecture**, here with 1 gateway, 3 satellite terminals and 2 clients in each local network
  
    sudo ./opensand-docker --simulate -i 2 -gw 1 -st 3 -c 2 
    
  
**More generally :**

    sudo ./opensand-docker --simulate -i $simulation_id -gw $nb_gw -st $nb_st -c $nb_clients
    
  Note that you cannot deploy :
  
    - more than 2 gateways
  
    - more than 5 satellite terminals
    
    - the "simulation_id" must be between 0 and 9 included and define ip adresses of the architecture.  
 
 Here is an exemple of deployement of a "full architecture". Note that many control packets are exchanged and sometimes lead to losts<;
 
 ![full-architecture](https://zupimages.net/up/20/09/vs8j.png)

    
OpenSAND offers the possibility to deploy a "split-gateway" : a gateway for physical aspect and a related gateway for network access (For more details : https://wiki.net4sat.org/doku.php?id=opensand:emulated_satcom_features:system:split_gateway:index). **To Deploy a split gateway, just replace -gw by -sgw (you can still deploy until 2 split gateways)**

**Use sand-manager GUI to start a simulation**

        sudo sand-manager -i
        
 The orchestrator automatically launch sand-manager but there could be some problems with the GUI part. A timer expires when the architecture is wide. In case of problem, remove the current GUI, kill the sand-manager (pkill sand-manager) process and re-try the sand-manager -i command.

**While simulation running, you can modify some parameters by**
        
        - using the GUI interface (the simulation must be previously stopped)
        OR
        - using the CLI
        
        sudo ./opensand-docker --simulation-change -id ${simulation_id} -gw 1 -spot 1 -fbw 100
        This command will set the forward bandwidth to 100MHz for the GW 1 in the spot 1 (by default 50MHz)
     
        sudo ./opensand-docker --simulation-change -id ${simulation_id} -d 100.
        This command will set the delay to 100 ms (by default 125 ms)
        

**By default, Satellite Terminals does have Internet Access through their docker local network. If you want to use the Emulation network for Satellite Terminals, execute the following command while simulation is running :

                
         sudo ./opensand-docker --simulation-change --internet-access yes
         
 This command set default route to the OpenSAND GW associated to each Satellite Terminal.
 
 **Current simulation OpenSAND entities are listed with the following command :**
         
         sudo ./opensand-docker --list-simulation

**Running containers are listed with :**

        sudo docker ps 
        
![docker ps](https://zupimages.net/up/20/09/nmen.png)
        
**Access to a running client with following command**
 
        sudo docker exec -it ws-$LAN_GW-$client_id-$simulation_id (use docker ps command to know exactly the name of your clients containers)
        
Note that default route is configured as its associated LAN_GW.


  **Remove the architecture with simulation id equal to $simulation_id** (i correspond to the id of the simulation, by default 0 if not precised) : 
 
    sudo ./opensand-docker --destroy -i $simulation_id
    
 **A recommended practice is to exit the manager GUI after deleting the architecture**
    
   
  
