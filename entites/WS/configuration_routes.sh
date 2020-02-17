#!/bin/bash

ip r del default
ip r add default via $addr_gateway
