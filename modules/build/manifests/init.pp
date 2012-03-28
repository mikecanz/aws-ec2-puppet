class build {

    package { [
                "php", 
                "php-devel", 
                "php-pear", 
                "ruby-devel", 
                "gcc", 
                "rpm-build",
                "httpd-devel",
              ]:
        ensure => installed,
    }

    package { ["libssh2", "libssh2-devel"]:
        ensure => installed,
    }

    file { "/yumvol":
        ensure => directory,
    }

}
