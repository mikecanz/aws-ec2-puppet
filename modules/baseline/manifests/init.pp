class baseline {  
    Service {
        hasstatus => true,
        hasrestart => true
    }

    package { ["perl-Time-HiRes", "tree"]:
        ensure => installed,
    }

    service { "crond":
        enable => true,
        ensure => running,
    }

    file { "/etc/bashrc":
        source => "puppet:///modules/baseline/etc/bashrc",
        owner  => "root",
        group  => "root",
        mode   => 664,
    }
}
