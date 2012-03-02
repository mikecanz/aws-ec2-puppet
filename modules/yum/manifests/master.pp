class yum::master inherits yum {
    include nginx

    file { "/etc/nginx/conf.d/yum.conf":
        source => "puppet:///modules/yum/etc/nginx/conf.d/yum.conf",
        owner => "root",
        group => "root",
        mode  => 664,
    }
}
