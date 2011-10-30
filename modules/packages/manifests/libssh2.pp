class packages::libssh2 inherits packages {

    package { "libssh2":
        ensure => installed,
    }

}
