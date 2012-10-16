class php-fpm {

        File { 
            owner   => "root", 
            group   => "root", 
            mode    => 644,
            require => Package["php54-fpm"],
        }

        package { ["php54-fpm"]:
            ensure => installed,
        }

        service { "php-fpm":
            enable     => true,
            ensure     => running,
            hasrestart => true,
            subscribe  => Package["php54-fpm"],
        }

        file { "/etc/php-fpm.conf":
            source => "puppet:///modules/php-fpm/etc/php-fpm.conf",
        }

}
