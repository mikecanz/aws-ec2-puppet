class baseline {  

    Service {
        hasstatus => true,
        hasrestart => true
    }

    service { "crond":
        enable => true,
        ensure => running,
    }

    file { "/etc/bashrc":
        source => "puppet:///modules/baseline/etc/bashrc",
    }

    file { "/etc/motd":
         source => "puppet:///modules/baseline/etc/motd",
    }
}
