#!/bin/bash

yum install -y yum-utils device-mapper-persistent-data lvm2

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

yum install -y docker-ce
yum install -y jq bind-utils
usermod -a -G docker elkuser
systemctl enable docker
systemctl start docker

curl -s -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
 
chmod 755 /usr/local/bin/docker-compose
# turn down kswapd activity
echo "vm.swappiness=0" >> /etc/sysctl.conf
echo 1 > /proc/sys/vm/drop_caches

# Need to update this for running elasticsearch without failing bootstrap check
echo "vm.max_map_count=262144" >> /etc/sysctl.conf

# Increase open file descriptors for elasticsearch bootstrap checks
echo "fs.file-max=100000" >> /etc/sysctl.conf
echo "* soft nofile 1024000" >> /etc/security/limits.conf
echo "* hard nofile 1024000" >> /etc/security/limits.conf
echo "* soft memlock unlimited" >> /etc/security/limits.conf
echo "* hard memlock unlimited" >> /etc/security/limits.conf
echo "elastic soft nofile 1024000" >> /etc/security/limits.conf
echo "elastic hard nofile 1024000" >> /etc/security/limits.conf
echo "elastic soft memlock unlimited" >> /etc/security/limits.conf
echo "elastic hard memlock unlimited" >> /etc/security/limits.conf
echo "root soft nofile 1024000" >> /etc/security/limits.conf
echo "root hard nofile 1024000" >> /etc/security/limits.conf
echo "root soft memlock unlimited" >> /etc/security/limits.conf
echo "ulimit -Sn 65536" >> /root/.bashrc
echo "ulimit -Hn 65536" >> /root/.bashrc
echo "session required pam_limits.so" >> /etc/pam.d/common-session
echo "session required pam_limits.so" >> /etc/pam.d/common-session-noninteractive

# Needed for docker containers to be able to talk to the internet
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p

