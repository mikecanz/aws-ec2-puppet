include baseline

node default {
    if $ec2_security_groups =~ /webserver/ {
        include puppet
        include httpd
        include yum
    } else {
        notify {"No definition for security group: $ec2_security_groups":}
    }
}

