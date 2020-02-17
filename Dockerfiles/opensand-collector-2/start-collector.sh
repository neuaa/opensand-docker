#!/bin/bash

rm /var/run/avahi-daemon/pid
rm /var/run/sand-collector/pid
/etc/init.d/dbus restart
/etc/init.d/avahi-daemon restart
sand-collector
