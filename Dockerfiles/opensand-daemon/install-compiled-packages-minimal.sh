#!/bin/bash

#installs packages required for a ST/SAT/GW

folder=/opensand-compiled-packages

#install requirements
apt-get install -y --allow-unauthenticated libgse-dev librle-dev librohc-dev

#install output module
apt install -y --allow-unauthenticated $folder/libopensand-output_5.1.2_amd64.deb
apt install -y --allow-unauthenticated $folder/libopensand-output-dbg_5.1.2_amd64.deb
apt install -y --allow-unauthenticated $folder/libopensand-output-dev_5.1.2_amd64.deb

#install configuration module
apt install -y --allow-unauthenticated $folder/libopensand-conf_5.1.2_amd64.deb
apt install -y --allow-unauthenticated $folder/libopensand-conf-dbg_5.1.2_amd64.deb
apt install -y --allow-unauthenticated $folder/libopensand-conf-dev_5.1.2_amd64.deb

#install RT Module
apt install -y --allow-unauthenticated $folder/libopensand-rt_5.1.2_amd64.deb
apt install -y --allow-unauthenticated $folder/libopensand-rt-dbg_5.1.2_amd64.deb
apt install -y --allow-unauthenticated $folder/libopensand-rt-dev_5.1.2_amd64.deb


#install Core Module
apt install -y --allow-unauthenticated $folder/opensand-core_5.1.2_amd64.deb
apt install -y --allow-unauthenticated $folder/opensand-core-conf_5.1.2_amd64.deb
apt install -y --allow-unauthenticated $folder/opensand-core-dbg_5.1.2_amd64.deb
#sous partie de core (Plugin library)
apt install -y --allow-unauthenticated $folder/libopensand-plugin_5.1.2_amd64.deb
apt install -y --allow-unauthenticated $folder/libopensand-plugin-dbg_5.1.2_amd64.deb
apt install -y --allow-unauthenticated $folder/libopensand-plugin-dev_5.1.2_amd64.deb

#install daemon module
apt install -y --allow-unauthenticated $folder/opensand-daemon_5.1.2_amd64.deb

#install GSE plugin
apt install -y --allow-unauthenticated $folder/libopensand-gse-encap-plugin_5.1.2_amd64.deb
apt install -y --allow-unauthenticated $folder/libopensand-gse-encap-plugin-conf_5.1.2_amd64.deb
apt install -y --allow-unauthenticated $folder/libopensand-gse-encap-plugin-dbg_5.1.2_amd64.deb
apt install -y --allow-unauthenticated $folder/libopensand-gse-encap-plugin-manager_5.1.2_amd64.deb

#install RLE plugin
apt install -y --allow-unauthenticated $folder/libopensand-rle-encap-plugin_5.1.2_amd64.deb
apt install -y --allow-unauthenticated $folder/libopensand-rle-encap-plugin-conf_5.1.2_amd64.deb
apt install -y --allow-unauthenticated $folder/libopensand-rle-encap-plugin-dbg_5.1.2_amd64.deb
apt install -y --allow-unauthenticated $folder/libopensand-rle-encap-plugin-manager_5.1.2_amd64.deb

#install ROHC plugin
apt install -y --allow-unauthenticated $folder/libopensand-rohc-lan-adapt-plugin_5.1.2_amd64.deb
apt install -y --allow-unauthenticated $folder/libopensand-rohc-lan-adapt-plugin-conf_5.1.2_amd64.deb
apt install -y --allow-unauthenticated $folder/libopensand-rohc-lan-adapt-plugin-dbg_5.1.2_amd64.deb
apt install -y --allow-unauthenticated $folder/libopensand-rohc-lan-adapt-plugin-manager_5.1.2_amd64.deb
