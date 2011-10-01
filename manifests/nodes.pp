node default {
    if $ec2_security_groups =~ /webserver/ {
        include httpd
    } else {
        notify {"No definition for security group: $ec2_security_groups":}
    }
}

