include baseline

node default {
    #########################################################################
    # This is old and should go away once all servers of this type are gone #
    #########################################################################
    if $ec2_security_groups =~ /(mysql-webserver)/ {
        include httpd
        include packages::php
        include mysqld
    }

    ##################################
    # This is old and should go away #
    ##################################
    if $ec2_security_groups =~ /(mongodb-devserver)/ {
        include httpd
        include mongod
    }

    if $ec2_security_groups =~ /webserver-nginx/ {
        include nginx
    }

    if $ec2_security_groups =~ /webserver-httpd/ {
        include httpd
        include packages::php
    }

    if $ec2_security_groups =~ /gearman-worker-nodejs/
        include gearman
        include nodejs
    }

    if $ec2_security_groups =~ /gearman-master/ {
        include gearman::master
    }

    if $ec2_security_groups =~ /db-mysql/ {
        include mysqld
    }

    if $ec2_security_groups =~ /db-mongo/ {
        include mongod
    }

    if $ec2_security_groups =~ /yum-master/ {
        include httpd
        include yum::master
    }

    if $ec2_security_groups =~ /admin/ {
        include build
    } 
}
