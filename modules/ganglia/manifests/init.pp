class ganglia {

    file { ["/etc/ganglia", "/etc/ganglia/conf.d"]:
        owner => root,
        group => root,
        mode  => 755,
        ensure => directory, 
    }

}
