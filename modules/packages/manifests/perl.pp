class packages::perl inherits packages {

    package { [
                "argyle-perlbrew",
              ]:
        ensure => installed,
    }

    package { [
                "perl-Term-ANSIColor",
              ]:
        ensure => latest,
    }

    realize Package["perl-DBD-MySQL"]
}
