class packages::php inherits packages {

    include ::php

    package { [
                "php-pecl-ssh2",
                "php-xml",
                "php-pecl-apc",
                "php-gd",
                "php-intl",
                "php-mysql",
                "php-mcrypt",
                "suphp",
              ]:
        ensure => installed,
    }

    package { "php":
        ensure => "5.3.23-1.33.amzn1",
    }

    package { "pcre":
        ensure => "8.21-5.3.amzn1",
    }

    if $is_dev == "true" {

        package { "php-phpunit-PHPUnit":
            ensure => installed,
            require => Package["php"],
        }

    }

}
