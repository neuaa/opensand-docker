#!/bin/bash

#send modify bandwidth
#$1 = type
#$2 = gw id
#$3 = spot type
#$4 = valeur

#check params number
if [ $# != 4 ]; then
	echo "syntaxe : ./modify_bandwidth type gw_id spot-id newValue"
        echo "exemple : ./modify_bandwidth forward 0 1 500"
        echo "for forward link, gw0, spot1 and 500Mhz as new value" 
	exit 1
fi



if [ $1 == "forward" ] ; then
	type=0
else 
	if [ $1 == "return" ]; then
		type=1
	else
		echo "type must be forward or return"
		exit 1
	fi
fi



message="$3:$2:$type:$4"

#detect the number of running STs
nbRunningST=$(sudo docker ps | grep opensand-daemon | grep st | wc -l)
#detect the number of running GWs
nbRunningGW=$(sudo docker ps | grep opensand-daemon | grep gw | wc -l)

simulation_id=0 #TODO change it, use parameter or read from file

ip_sat="192.168.1${simulation_id}.10"
ip_gw="192.168.1${simulation_id}.20"
ip_gw2="192.168.1${simulation_id}.25"
ip_st="192.168.1$simulation_id.40"
ip_st2="192.168.1$simulation_id.50"
ip_st3="192.168.1$simulation_id.60"
ip_st4="192.168.1$simulation_id.70"
ip_st5="192.168.1$simulation_id.80"

echo "sending $message to SAT, STs, and GWs"

#send ConfUpdate to SAT
echo $message | nc $ip_sat 5335 &

#send ConfUpdate to STs
case $nbRunningST in
1) 
echo "nbRunningST = 1" #TODO debug, remove
echo $message | nc $ip_st 5335 & 
;; #break
2) 
echo "nbRunningST = 2" #TODO debug, remove
echo $message | nc $ip_st 5335 & 
echo $message | nc $ip_st2 5335 & 
;; #break
3) 
echo "nbRunningST = 3" #TODO debug, remove
echo $message | nc $ip_st 5335 & 
echo $message | nc $ip_st2 5335 & 
echo $message | nc $ip_st3 5335 & 
;; #break
4) 
echo "nbRunningST = 4" #TODO debug, remove
echo $message | nc $ip_st 5335 & 
echo $message | nc $ip_st2 5335 & 
echo $message | nc $ip_st3 5335 & 
echo $message | nc $ip_st4 5335 & 
;; #break
5) 
echo "nbRunningST = 5" #TODO debug, remove
echo $message | nc $ip_st 5335 & 
echo $message | nc $ip_st2 5335 & 
echo $message | nc $ip_st3 5335 & 
echo $message | nc $ip_st4 5335 & 
echo $message | nc $ip_st5 5335 & 
;; #break
*) echo "Too much ST are running" ; exit 1
;; #break
esac


#send ConfUpdate to GWs
case $nbRunningGW in
1) 
echo "nbRunningGW = 1" #TODO debug, remove
echo $message | nc $ip_gw 5335 &
echo $message | nc $ip_gw2 5335 &
;; #break
2) 
echo "nbRunningGW = 2" #TODO debug, remove
;; #break
*) echo "Too much GW are running" ; exit 1
;; #break
esac









