class packages::php inherits packages {

    package { [
                "php",
                "php-pecl-ssh2",
              ]:
        ensure => installed,
    }
}
