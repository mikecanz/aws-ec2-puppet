class packages::php inherits packages {

    include ::php

    package { [
                "php-pecl-ssh2",
                "php-xml",
                "php-pecl-apc",
                "php-gd",
                "php-intl",
                "php-mcrypt",
                "suphp",
              ]:
        ensure => installed,
    }

    package { "php":
        ensure => "5.3.20-1.29.amzn1",
    }

    package { "pcre":
        ensure => "8.21-5.3.amzn1",
    }

    if $virtual == "virtualbox" {

        package { "php-phpunit-PHPUnit":
            ensure => installed,
            require => Package["php"],
        }

    }

}
