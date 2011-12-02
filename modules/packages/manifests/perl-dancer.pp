class packages::perl-dancer inherits packages {

    package { "perl-Dancer":
        ensure => installed,
    }
}
