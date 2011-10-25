include baseline

node default {
    if $ec2_security_groups =~ /webserver/ {
        include httpd
        include yum
        include php
        include libssh2
    } elsif $ec2_security_groups =~ /(devserver|mysql-webserver)/ {
        include httpd
        include yum
        include php
        include libssh2
        include mysql
    } elsif $ec2_security_groups =~ /admin/ {
        include build
        include aws
        include git
        include httpd
        include yum::master
        include fail2ban
    } else {
        notify {"No definition for security group: $ec2_security_groups":}
    }
}

