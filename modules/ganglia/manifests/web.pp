class ganglia::web {

    include ganglia::gmetad

    package { [
                "ganglia-web",
              ]:
        ensure => installed,
    }

    file { "/etc/httpd/conf.d/ganglia.conf":
        source => "puppet:///modules/ganglia/etc/httpd/conf.d/ganglia.conf",
    }
}
