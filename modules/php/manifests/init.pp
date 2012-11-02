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
            "perl-Test-WWW-Mechanize-Dancer",
            "mod_ssl",
            "perl-Test-WWW-Mechanize-PSGI",
            "perl-Dancer-Plugin-REST",
            "perl-Starman",
            "perl-Dancer-Plugin-Email",
            "perl-Dancer-Plugin-Passphrase",
            "perl-Net-OAuth2",
            "perl-Dancer",
            "perl-Plack",
            "mod_perl",
            "httpd",
            "httpd-tools",
           ]:
           ensure => absent,
        }

        file { "/etc/php.ini":
            source => "puppet:///modules/php/etc/php.ini",
        }
}
