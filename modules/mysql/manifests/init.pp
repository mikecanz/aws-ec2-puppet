class mysql {
    package { [
                "mysql",
                "mysql-server",
                "perl-DBD-MySQL",
                "php-mysql",
              ]:
        ensure => installed,
    }
}
