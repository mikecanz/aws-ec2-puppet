class build {

    package { ["php", "php-devel", "php-pear"]:
        ensure => installed,
    }

    package { ["libssh2", "libssh2-devel"]:
        ensure => installed,
    }
}
