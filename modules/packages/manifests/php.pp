class packages::php inherits packages {

    include php

    package { [
                "php-pecl-ssh2",
                "php-pecl-apc",
                "php-pecl-gd",
                "php-mcrypt",
              ]:
        ensure => installed,
    }

    package { "php":
        ensure => "php-5.3.13",
    }
}
