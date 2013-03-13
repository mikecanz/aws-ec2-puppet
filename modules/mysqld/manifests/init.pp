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
        source => "puppet:///modules/mysqld/etc/my.cnf",
    }
}
