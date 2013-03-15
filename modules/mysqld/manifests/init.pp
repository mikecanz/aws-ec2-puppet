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

    if $id == "vagrant" {

        file { "/var/log/mysql/query.log":
            ensure => 'present',
            owner => mysql,
            group => mysql
        }
    }
}
