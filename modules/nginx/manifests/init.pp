
class nginx {

    package { "nginx":
        ensure => installed,
    }

    service { "nginx":
        enable => true,
    }

    # An erb that currently has no logic
    file { "/etc/nginx/nginx.conf":
        content => template("nginx/etc/nginx/nginx.conf.erb"),
        owner   => nginx,
        group   => nginx,
        require => Package["nginx"],
    }

}
