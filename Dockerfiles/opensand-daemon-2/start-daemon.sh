#!/bin/bash

rm /var/run/avahi-daemon/pid
rm /var/run/sand-daemon/pid
/etc/init.d/dbus restart
/etc/init.d/avahi-daemon restart
opensand_interfaces
cp /etc/opensand/daemonbck.conf /etc/opensand/daemon.conf
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv6.conf.all.forwarding=1
iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
sand-daemon -f
