class php-fpm {

        File { 
            owner   => "root", 
            group   => "root", 
            mode    => 644,
            require => Package["php-fpm"], # httpd package creates the apache user
        }

        package { ["php-fpm"]:
            ensure => installed,
        }

        service { "php-fpm":
            enable     => true,
            ensure     => running,
            hasrestart => true,
            subscribe  => Package["php"],
        }

        file { "/etc/php-fpm.conf":
            source => "puppet:///modules/php-fpm/etc/php-fpm.conf",
        }

}
