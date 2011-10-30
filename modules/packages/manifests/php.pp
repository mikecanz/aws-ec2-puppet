class packages::php inherits packages {

    package { "php":
        ensure => installed,
    }
}
