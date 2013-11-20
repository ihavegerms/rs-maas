#!/bin/bash
#Created for CentOS6

curl https://monitoring.api.rackspacecloud.com/pki/agent/linux.asc > /tmp/signing-key.asc
rpm --import /tmp/signing-key.asc

cat >/etc/yum.repos.d/rackspace-monitoring-agent.repo <<EOL
[rackspace]
name=Rackspace Monitoring
baseurl=http://stable.packages.cloudmonitoring.rackspace.com/centos-6-x86_64
enabled=1
EOL

yum update -y
yum install -y rackspace-monitoring-agent

rackspace-monitoring-agent --setup
