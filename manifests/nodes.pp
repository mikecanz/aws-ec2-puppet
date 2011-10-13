include baseline

node default {
    if $ec2_security_groups =~ /webserver/ {
        include puppet
        include httpd
        include yum
    } elsif $ec2_security_groups =~ /admin/ {
        include aws
        include puppet
        include git
        include httpd
        include yum::master
    } else {
        notify {"No definition for security group: $ec2_security_groups":}
    }
}

