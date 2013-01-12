#!/bin/bash

YUM_HOST=$1
YUM_PATH=$2
RPM_VERSION=$3

fpm -n aws-ec2-puppet -s dir -t rpm -v $RPM_VERSION -a noarch --prefix /etc/puppet modules/ manifests/
mv *.rpm /yumvol/yum/amazonami/2011-09/noarch
sudo createrepo /yumvol/yum/amazonami/2011-09/noarch
sudo createrepo /yumvol/yum/amazonami/2011-09/x86_64
sudo createrepo /yumvol/yum/amazonami/2011-09/i386
rsync -avz --delete /yumvol/yum/ $YUM_HOST:$YUM_PATH
