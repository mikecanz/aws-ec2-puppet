class packages::php inherits packages {

    include ::php

    package { [
                "php-pecl-ssh2",
                "php-xml",
                "php-pecl-apc",
                "php-gd",
                "php-pecl-gd",
                "php-mcrypt",
              ]:
        ensure => installed,
    }

    package { "php54":
        ensure => "php54-5.4.7",
    }
}
