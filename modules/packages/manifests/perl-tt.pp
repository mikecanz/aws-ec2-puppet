class packages::perl-tt inherits packages {

    package { "perl-Template-Toolkit":
        ensure => installed,
    }
}
