class php {

    package { ["php", "php-devel", "php-pear"]:
        ensure => installed,
    }
}
