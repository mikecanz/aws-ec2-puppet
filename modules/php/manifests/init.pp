class php {

        File { 
            owner   => "root", 
            group   => "root", 
            mode    => 644,
            require => Package["php54"], # php package creates the initial php.ini
        }

        package { [
            "php",
            "php-common",
            "php-pecl-ssh2",
            "php-xml",
            "php-pecl-apc",
            "php-gd",
            "php-pecl-gd",
            "php-mcrypt",
            "php-pecl-mongo",
            "php-cli",
            "php-pdo",
            "php-mysql",
            "php-pear",
           ]:
           ensure => absent,
        }

        file { "/etc/php.ini":
            source => "puppet:///modules/php/etc/php.ini",
        }
}
