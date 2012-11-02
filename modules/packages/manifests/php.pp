class packages::php inherits packages {

    include ::php

    package { [
                "php54-pecl-ssh2",
                "php54-xml",
                "php54-pecl-apc",
                "php54-gd",
                "php54-mcrypt",
              ]:
        ensure => installed,
        require => Package["php-common", "php-pear"],
    }

    package { "php54":
        ensure => "5.4.7",
    }

    package { "php-pear":
        ensure => "installed",
    }
}
