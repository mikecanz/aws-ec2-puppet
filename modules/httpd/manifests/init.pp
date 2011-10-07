class httpd {

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
            owner   => "apache",
            group   => "apache",
            require => Package["httpd"], # httpd package creates apache user
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
            owner  => "apache",
            group  => "apache",
            mode   => 644,
        }
}
