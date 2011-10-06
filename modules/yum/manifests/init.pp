class yum {

        package { "redhat-lsb":
                ensure => latest,
        }

        file { "/etc/yum.repos.d/internal.repo":
                owner => "root",
                group => "root",
                mode  => 644,
                content => template("yum/internal.repo.erb"),
        }
}
