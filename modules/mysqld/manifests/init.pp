class mysqld {

    include packages

    package { [
                "mysql",
                "mysql-server",
                "liquibase",
              ]:
        ensure => installed,
    }

    realize Package["perl-DBD-MySQL"]

    service { "mysqld":
        enable     => true,
        ensure     => running,
        subscribe  => Package["mysql"],
    }

    file { "/etc/my.cnf":
        content => template("mysqld/etc/my.cnf.erb")
    }

    if $is_dev == "true" {

        file { "/var/log/mysql" :
            ensure => "directory",
            owner => "mysql",
            group => "mysql",
            mode => 644,
        }

        file { "/var/log/mysql/query.log":
            notify => Service['mysqld'], 
            ensure => 'present',
            owner => 'mysql',
            group => 'mysql',
            mode => 0644,
            content => '',
            require => Package['mysql-server']
        }
    }
}
