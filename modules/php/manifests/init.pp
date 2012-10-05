class php {

        File { 
            owner   => "root", 
            group   => "root", 
            mode    => 644,
            require => Package["php"], # php package creates the initial php.ini
        }

        file { "/etc/php.ini":
            source => "puppet:///modules/php/etc/php.ini",
        }

        file { "/etc/php-fpm.conf":
            source => "puppet:///modules/php/etc/php-fpm.conf",
        }
}
