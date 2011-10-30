class packages::php-pecl-ssh2 inherits packages {

    package { "php-pecl-ssh2":
        ensure => installed,
    }
}
