class build {

    package { [
                "php54",
                "php54-devel",
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
