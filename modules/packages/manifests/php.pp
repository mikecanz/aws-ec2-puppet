class packages::php inherits packages {

    include ::php

    package { [
                "php-pecl-ssh2",
                "php-xml",
                "php-pecl-apc",
                "php-gd",
                "php-intl",
                "php-pecl-gd",
                "php-mcrypt",
                "suphp",
              ]:
        ensure => installed,
    }

    package { "php":
        ensure => "5.3.20",
    }
}
