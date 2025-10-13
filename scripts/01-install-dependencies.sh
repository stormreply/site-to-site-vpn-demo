#!/bin/bash

echo "BEGIN -- 01-install-dependencies.sh"

# NOTE: below suggestion usually not needed, but ssm agent seems
# to claim the rpm lock, forcing other yum installs to fail. see
# https://repost.aws/questions/QUgNz4VGCFSC2TYekM-6GiDQ/dnf-yum-both-fails-while-being-executed-on-instance-bootstrap-on-amazon-linux-2023

systemctl stop amazon-ssm-agent
sleep 5

apt-get update -y
apt-get install -y strongswan strongswan-starter

wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
chmod a+x /usr/local/bin/yq

grep -q -E '^(# *)?net\.ipv4\.ip_forward *= *1' /etc/sysctl.conf \
    && sed -i 's/^# *\(net\.ipv4\.ip_forward *= *1\)/\1/' /etc/sysctl.conf \
    || echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf

grep -q -E '^(# *)?net\.ipv6\.conf\.all\.forwarding *= *1' /etc/sysctl.conf \
    && sed -i 's/^# *\(net\.ipv6\.conf\.all\.forwarding *= *1\)/\1/' /etc/sysctl.conf \
    || echo 'net.ipv6.conf.all.forwarding=1' >> /etc/sysctl.conf

sysctl -p

systemctl start amazon-ssm-agent

echo "END ---- 01-install-dependencies.sh"
