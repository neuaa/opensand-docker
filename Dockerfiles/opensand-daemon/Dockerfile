FROM ubuntu:xenial

RUN echo "deb [trusted=yes] http://packages.net4sat.org/opensand xenial stable" | tee /etc/apt/sources.list.d/opensand.list
RUN apt-get update
RUN apt-get install -y opensand
RUN apt-get install -y net-tools
RUN apt-get install -y iptables
RUN apt-get install -y iputils-ping
RUN apt-get install -y netcat
RUN apt-get install -y software-properties-common
COPY start-daemon.sh /start-daemon.sh 
RUN chmod +x /start-daemon.sh
