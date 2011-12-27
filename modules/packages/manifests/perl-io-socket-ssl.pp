class packages::perl-io-socket-ssl inherits packages {

    package { "perl-IO-Socket-SSL":
        ensure => installed,
    }
}
