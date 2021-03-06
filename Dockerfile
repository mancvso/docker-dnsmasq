FROM ubuntu:14.04
MAINTAINER Vo Minh Thu <noteed@gmail.com>

RUN apt-get update
RUN apt-get install -q -y language-pack-en
RUN update-locale LANG=en_US.UTF-8

RUN apt-get install -q -y vim nano dnsutils

# Install dnsmaqk
RUN apt-get install -q -y dnsmasq && apt-get clean

# Configure dnsmasq
ADD dnsmasq.conf /etc/dnsmasq.conf
ADD logrotate_dnsmasq /etc/logrotate.d/dnsmasq
RUN echo 'listen-address=__LOCAL_IP__' >> /etc/dnsmasq.conf
RUN echo 'nameserver 8.8.8.8' >> /etc/resolv.dnsmasq.conf
RUN echo 'nameserver 8.8.4.4' >> /etc/resolv.dnsmasq.conf

# This directory will usually be provided with the -v option.
# RUN echo 'address=/example.com/xx.xx.xx.xx' >> /etc/dnsmasq.d/0hosts

ADD set-listen-address-and-run.sh /root/set-listen-address-and-run.sh

EXPOSE 53

CMD ["/root/set-listen-address-and-run.sh"]
