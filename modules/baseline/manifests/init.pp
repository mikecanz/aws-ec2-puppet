class baseline {  
    Service {
        hasstatus => true,
        hasrestart => true
    }

    File {
        owner => "root",
        group => "root",
        mode  => 644,
    }

    include puppet
    include monit
    include packages::perl

    package { [
                "tree",
                "screen",
                "fail2ban",
                "aws-apitools-cfn",
                "telnet",
                "git",
                "htop",
              ]:
        ensure => installed,
    }

    service { "crond":
        enable => true,
        ensure => running,
    }

    file { "/etc/bashrc":
        source => "puppet:///modules/baseline/etc/bashrc",
    }

    file { "/etc/logrotate.conf":
        source => "puppet:///modules/baseline/etc/logrotate.conf",
    }

    file { "/var/log/rotated":
        ensure => directory,
    }

    service { "yum-updatesd":
        ensure => stopped,
        enable => false,
    }

}
