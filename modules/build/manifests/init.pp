class build {

    package { ["php", "php-devel", "php-pear", "ruby-devel", "gcc"]:
        ensure => installed,
    }

    package { ["libssh2", "libssh2-devel"]:
        ensure => installed,
    }
}
