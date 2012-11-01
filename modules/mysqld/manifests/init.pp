class mysqld {

    include packages

    package { [
                "mysql",
                "mysql-server",
                "php54-mysql",
                "liquibase",
              ]:
        ensure => installed,
        require => Package["php"],
    }

    realize Package["perl-DBD-MySQL"]

    service { "mysqld":
        enable     => true,
        ensure     => running,
        subscribe  => Package["mysql"],
    }
}
