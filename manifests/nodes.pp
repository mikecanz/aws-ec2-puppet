include baseline

node default {
    if $ec2_security_groups =~ /(webserver|admin)/ {
        include puppet
        include httpd
        include yum
        include aws-cf
        include ec2-api-tools
        include ec2-metadata
    } else {
        notify {"No definition for security group: $ec2_security_groups":}
    }
}

