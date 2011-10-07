
class yum::master inherits yum {

    include httpd

    file { "/etc/httpd/vhosts.d/yum.conf":
        source => "puppet:///modules/yum/etc/httpd/vhosts.d/yum.conf",
    }

}
