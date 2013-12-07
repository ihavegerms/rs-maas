#!/bin/bash
#Created for CentOS6
#Purpose: installs rackspace-monitoring-agent and fires off the setup

echo "Download signing-key and import.."
curl https://monitoring.api.rackspacecloud.com/pki/agent/linux.asc > /tmp/signing-key.asc
rpm --import /tmp/signing-key.asc

echo "Adding repo for monitoring agent.."
cat >/etc/yum.repos.d/rackspace-monitoring-agent.repo <<EOL
[rackspace]
name=Rackspace Monitoring
baseurl=http://stable.packages.cloudmonitoring.rackspace.com/centos-6-x86_64
enabled=1
EOL

echo "Updating.."
yum update -y
echo "Installing the monitoring agent.."
yum install -y rackspace-monitoring-agent
echo "Launching agent setup.."
echo ""
rackspace-monitoring-agent --setup
