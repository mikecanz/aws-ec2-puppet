include baseline

node default {
    if $ec2_security_groups =~ /webserver/ {
        include puppet
        include httpd
        include yum
    } elsif $ec2_security_groups =~ /admin/ {
        include puppet
        include httpd
        include yum::master
        include aws-cf
        include ec2-api-tools
        include ec2-metadata
    } else {
        notify {"No definition for security group: $ec2_security_groups":}
    }
}

