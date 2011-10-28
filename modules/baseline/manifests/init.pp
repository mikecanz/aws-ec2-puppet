class baseline {  
    Service {
        hasstatus => true,
        hasrestart => true
    }

    include puppet
    include monit

    package { [
                "perl-Time-HiRes",
                "tree",
                "screen",
                "fail2ban",
                "aws-apitools-cfn",
                "git",
              ]:
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
