class mysqld {

    include packages

    package { [
                "mysql",
                "mysql-server",
                "php-mysql",
              ]:
        ensure => installed,
    }

    realize Package["perl-DBD-MySQL"]

    service { "mysqld":
        enable     => true,
        ensure     => running,
        subscribe  => Package["mysql"],
    }
}
