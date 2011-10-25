include baseline

# webserver                     Basic webserver that might use some other data store or may just not need one
#
# devserver|mysql-webserver     Servers that include mysql.  We have two types because webserver will just 
#                               have ports 80 and 443 open while the devserver will also have port 22.
#
# admin                         Admin and build machine.  If one wants to ssh into a webserver they need
#                               to go through this machine.  Also hosts the private yum repo

node default { 
    if $ec2_security_groups =~ /webserver/ {
        include httpd
        include yum
        include php
        include php-pecl-ssh2
    } elsif $ec2_security_groups =~ /(devserver|mysql-webserver)/ {
        include httpd
        include yum
        include php
        include php-pecl-ssh2
        include mysql
    } elsif $ec2_security_groups =~ /admin/ {
        include build
        include aws
        include git
        include httpd
        include yum::master
    } else {
        notify {"No definition for security group: $ec2_security_groups":}
    }
}
