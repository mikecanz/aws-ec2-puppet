class httpd24 {

        include yum

        File { 
            owner   => "apache", 
            group   => "apache", 
            mode    => 644,
            require => Package["httpd24"], # httpd package creates the apache user
        }

        package { ["httpd24", "mod24_ssl"]:
            ensure => installed,
        }

        service { "httpd":
            enable     => true,
            ensure     => running,
            hasrestart => true,
            subscribe  => Package["httpd24", "mod24_ssl"],
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
            source => "puppet:///modules/httpd24/etc/httpd/conf/httpd.conf",
        }

        file { "/etc/httpd/conf.d/ssl.conf":
            source => "puppet:///modules/httpd24/etc/httpd/conf.d/ssl.conf",
        }

        file { "/etc/logrotate.d/httpd":
            source => "puppet:///modules/httpd24/etc/logrotate.d/httpd",
        }
}
