class packages::perl-yaml inherits packages {

    package { "perl-YAML":
        ensure => installed,
    }
}
