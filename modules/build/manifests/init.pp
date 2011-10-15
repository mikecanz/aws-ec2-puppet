class build {

    package { ["php", "php-devel", "php-pear", "ruby-devel", "gcc", "rpm-build"]:
        ensure => installed,
    }

    package { ["libssh2", "libssh2-devel"]:
        ensure => installed,
    }
}
