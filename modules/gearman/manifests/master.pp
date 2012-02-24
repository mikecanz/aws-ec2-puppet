
class gearman::master inherits gearman {
    
    include yum

    File {
        owner   => "root",
        group   => "root",
        mode    => 644,
        require => Package["gearmand"],
    }

    package { "gearmand":
        ensure => installed,
    }

    package { "gearmand-server":
        ensure => installed,
    }

    service { "gearmand":
        enable     => true,
        ensure     => running,
        hasrestart => true,
        subscribe  => Package["gearmand-server"],
    }
}
