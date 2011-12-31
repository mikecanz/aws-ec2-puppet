class packages::perl-dancer inherits packages {

    package { "perl-Dancer":
        ensure => installed,
    }

    package { "perl-Dancer-Plugin-REST":
        ensure => installed,
    }
}
