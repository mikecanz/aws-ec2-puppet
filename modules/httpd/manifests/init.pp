class httpd {

        include yum
        include ganglia

        File { 
            owner   => "apache", 
            group   => "apache", 
            mode    => 644,
            require => Package["httpd"], # httpd package creates the apache user
        }

        package { ["httpd", "mod_ssl"]:
            ensure => installed,
        }

        service { "httpd":
            enable     => true,
            ensure     => running,
            hasrestart => true,
            subscribe  => Package["httpd", "mod_ssl"],
        }

        file { ["/usr/local/apache", "/usr/local/apache/htdocs"]:
            ensure => "directory",
        }

        file { [ "/var/cache/apache", "/var/cache/apache/wsdl_cache", "/var/tmp/php" ]:
            ensure  => "directory",
        }

        file { "/var/log/httpd":
            ensure => "directory",
        }

        file { "/etc/httpd":
            ensure => "directory",
        }

        file { [ "/etc/httpd/conf", "/etc/httpd/conf.d", "/etc/httpd/vhosts", "/etc/httpd/vhosts.d" ]:
            ensure => "directory",
            recurse => true,
        }

        file { "/etc/httpd/conf/httpd.conf":
            source => "puppet:///modules/httpd/etc/httpd/conf/httpd.conf",
        }

        file { "/etc/ganglia/conf.d/apache_status.pyconf":
            source => "puppet:///modules/httpd/etc/ganglia/conf.d/apache_status.pyconf",
        }

        file { "/etc/httpd/conf.d/ssl.conf":
            source => "puppet:///modules/httpd/etc/httpd/conf.d/ssl.conf",
        }

        file { "/etc/logrotate.d/httpd":
            source => "puppet:///modules/httpd/etc/logrotate.d/httpd",
        }
}
