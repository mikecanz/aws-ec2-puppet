class mysql {

    include yum

    package { [
                "mysql",
                "mysql-server",
                "perl-DBD-MySQL",
                "php-mysql",
              ]:
        ensure => installed,
    }

    service { "mysqld":
        enable     => true,
        ensure     => running,
        subscribe  => Package["mysql"],
    }
}
