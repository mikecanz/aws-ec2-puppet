class yum {

    Package { require => File["/etc/yum.repos.d/external.repo","/etc/yum.repos.d/epel.repo"], }

    package { [
                "redhat-lsb",
                "yum-plugin-downloadonly",
                "createrepo",
              ]:
        ensure => latest,
    }

    file { "/etc/yum.repos.d/external.repo":
        source => "puppet:///modules/yum/etc/yum.repos.d/external.repo",
        owner => "root",
        group => "root",
        mode  => 644,
    }

    file { "/etc/yum.repos.d/epel.repo":
        source => "puppet:///modules/yum/etc/yum.repos.d/epel.repo",
        owner => "root",
        group => "root",
        mode  => 644,
    }

    file { "/etc/yum.repos.d/10gen.repo":
        content => template("yum/etc/yum.repos.d/10gen.repo.erb"),
        owner => "root",
        group => "root",
        mode  => 644,
    }
}
