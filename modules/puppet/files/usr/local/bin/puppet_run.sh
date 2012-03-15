#!/bin/bash

tags = `facter -p ec2_instance_tags`

yum clean all 2>&1 > /dev/null
/usr/bin/yum -y upgrade aws-ec2-puppet aws-ec2-puppet-private-accessium 2>&1 > /tmp/yum.log
/usr/bin/puppet apply --verbose --modulepath /etc/puppet/modules /etc/puppet/manifests/nodes.pp 2>&1 > /tmp/puppet.log
/usr/bin/puppet apply --verbose --modulepath /etc/puppet/modules /etc/puppet/manifests/private-nodes.pp 2>&1 > /tmp/puppet-private.log
