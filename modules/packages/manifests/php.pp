class packages::php inherits packages {

    include php

    package { [
                "php",
                "php-pecl-ssh2",
                "php-pecl-apc",
                "php-pecl-gd",
                "php-mcrypt",
              ]:
        ensure => installed,
    }
}
