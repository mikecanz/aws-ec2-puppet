include baseline

# webserver                     Basic webserver that might use some other data store or may just not need one
#
# devserver|mysql-webserver     Servers that include mysql.  We have two types because webserver will just 
#                               have ports 80 and 443 open while the devserver will also have port 22.
#
# admin                         Admin and build machine.  If one wants to ssh into a webserver they need
#                               to go through this machine.  Also hosts the private yum repo

node default { 
    if $ec2_security_groups =~ /^webserver$/ {
        include httpd
        include packages::php
    }

    if $ec2_security_groups =~ /(^mysql-devserver$|^mysql-webserver$)/ {
        include httpd
        include packages::php
        include mysqld
    }

    if $ec2_security_groups =~ /(^mongodb-devserver$|mongodb-webserver)/ {
        include httpd
        include mongod
    }

    if $ec2_security_groups =~ /^gearman-worker$/ {
        include gearman
    }

    if $ec2_security_groups =~ /gearman-master/ {
        include gearman::master
    }

    if $ec2_security_groups =~ /^yum-master$/ {
        include httpd
        include yum::master
    }

    if $ec2_security_groups =~ /^admin$/ {
        include build
    } 
}
