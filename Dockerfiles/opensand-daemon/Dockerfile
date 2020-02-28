FROM ubuntu:xenial


RUN echo "deb [trusted=yes] http://packages.net4sat.org/opensand xenial stable" | tee /etc/apt/sources.list.d/opensand.list
RUN apt-get update
COPY install-compiled-packages-minimal.sh /install-compiled-packages-minimal.sh 
COPY opensand-compiled-packages /opensand-compiled-packages
RUN chmod +x /install-compiled-packages-minimal.sh 
RUN bash /install-compiled-packages-minimal.sh
RUN apt-get install -y net-tools
RUN apt-get install -y iptables
RUN apt-get install -y iputils-ping
RUN apt-get install -y netcat
RUN apt-get install -y software-properties-common
COPY start-daemon.sh /start-daemon.sh 
RUN chmod +x /start-daemon.sh
RUN apt-get install -y iperf3
