#!/bin/bash

# The grabs a comma-separated list of customers as tagged in the ec2 management interface
# Use the 'name' of customers for the tag and a (comma-separated) list of customer names as the value of the tag
# The standard is to have an rpm named aws-ec2-puppet-private-<customer name>, one per customer/client
# This is in addition to the "public" rpm, based off of http://github.com/mikecanz/aws-ec2-puppet

tags=`facter -p | grep ec2_instance_tag_customers | awk '{print $3}'`

if [ -n "$tags" ]; then
    custs=(`echo $tags | sed s/,/\ /g`)
    pkgs=""
    for i in "${custs[@]}"; do
        pkgs="aws-ec2-puppet-private-$i $pkgs"
    done
fi

# The next three lines should always execute
# If there are no customer packages, then $pkgs is silently ignored
# However, there should always be at least one "customer" package - your own

yum clean all 2>&1 > /dev/null
/usr/bin/yum -y upgrade aws-ec2-puppet $pkgs 2>&1 > /tmp/yum.log
/usr/bin/puppet apply --verbose --modulepath /etc/puppet/modules /etc/puppet/manifests/nodes.pp 2>&1 > /tmp/puppet.log

#In your private customer repos, named the nodes file <customer name>-nodes.pp

if [ -n "$custs" ]; then
    for i in "${custs[@]}"; do
    /usr/bin/puppet apply --verbose --modulepath /etc/puppet/modules /etc/puppet/manifests/$i-nodes.pp 2>&1 > /tmp/puppet-$i.log
    done
fi
