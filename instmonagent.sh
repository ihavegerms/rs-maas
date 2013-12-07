#!/bin/bash
#Created for CentOS6
#Purpose: installs rackspace-monitoring-agent and fires off the setup

echo "Checking user.."
if [ "$(id -u)" != "0" ]; then
echo "This script must be run as ROOT. You have attempted to run this as $USER use sudo $@ or change to root." 1>&2
   exit 1
fi

echo "Checking os for [centos].."
os=$(cat /etc/*release*|head -1|awk -F" " {' print $1, $3 '}|tr '[:upper:]' '[:lower:]')
if [[ "$os" == *"$centos"* ]]; then
  echo "confirmed os - [$os].."
  echo "Download signing-key and import.."
  curl -s https://monitoring.api.rackspacecloud.com/pki/agent/linux.asc > /tmp/signing-key.asc
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

else
  echo "This script was written for centos."
  echo "Exiting.."
  exit 1
fi
