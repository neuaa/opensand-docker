FROM ubuntu:xenial

RUN apt-get update
RUN apt-get install -y net-tools
RUN apt-get install -y iproute2
RUN apt-get install -y iptables
RUN apt-get install -y iputils-ping
RUN apt-get install -y netcat
RUN apt-get install -y iperf3
RUN apt-get install -y software-properties-common
RUN apt-get install -y apache2
COPY start-server.sh /start-server.sh
RUN chmod +x /start-server.sh
