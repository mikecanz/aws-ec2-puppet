class yum {
    package { "redhat-lsb":
        ensure => latest,
    }

    package { "yum-plugin-downloadonly":
        ensure => latest,
    }
  
    file { "/etc/yum.repos.d/internal.repo":
        owner => "root",
        group => "root",
        mode  => 644,
        content => template("yum/internal.repo.erb"),
    }

    file { "/etc/yum.repos.d/epel.repo":
        source => "puppet:///modules/yum/etc/yum.repos.d/epel.repo",
        owner => "root",
        group => "root",
        mode  => 644,
    }
}
