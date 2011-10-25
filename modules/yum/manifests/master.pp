class yum::master inherits yum {

    include httpd

    file { "/etc/httpd/vhosts.d/yum.conf":
        source => "puppet:///modules/yum/etc/httpd/vhosts.d/yum.conf",
        owner => "root",
        group => "root",
        mode  => 664,
    }

    #file { "/etc/yum.repos.d/epel.repo":
    #    source => "puppet:///modules/yum/etc/yum.repos.d/epel.repo",
    ##    owner => "root",
    #    group => "root",
    #    mode  => 644,
    #}
}
