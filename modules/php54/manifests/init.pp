class php54 {

    File { 
        owner   => "root", 
        group   => "root", 
        mode    => 644,
        require => Package["php54"], # php package creates the initial php.ini
    }

    package { [
                "php54-pecl-ssh2",
                "php54-xml",
                "php54-pecl-apc",
                "php54-gd",
                "php54-mcrypt",
              ]:
        ensure => installed,
        require => Package["php54-common", "php-pear"],
    }

    package { ["php54", "php54-common"]:
        ensure => "5.4.7",
    }

    package { "php-pear":
        ensure => "installed",
    }

    file { "/etc/php.ini":
        source => "puppet:///modules/php54/etc/php.ini",
    }
}
