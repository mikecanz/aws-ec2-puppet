
#!/bin/bash

cat > /etc/yum.repos.d/external.repo << EOF
[external-noarch]
name=Public External Repo
baseurl=http://loop.phpwebhosting.com/~mfc5/yumrepo/amazonami/2011-09/noarch/
enabled=1
gpgcheck=0
metadata_expire=1200
EOF

yum install -y puppet aws-ec2-puppet
puppet apply --modulepath /etc/puppet/modules /etc/puppet/manifests/nodes.pp
sleep 30
puppet apply --modulepath /etc/puppet/modules /etc/puppet/manifests/nodes.pp
sleep 30
puppet apply --modulepath /etc/puppet/modules /etc/puppet/manifests/nodes.pp
