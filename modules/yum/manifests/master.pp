class yum::master inherits yum {
    include nginx

    file { "/etc/nginx/conf.d/yum.conf":
        source => "puppet:///modules/yum/etc/nginx/conf.d/yum.conf",
        owner => "root",
        group => "root",
        mode  => 664,
    }

    file { [
        "/yumvol/amazonami", 
        "/yumvol/amazonami/2011-09", 
        "/yumvol/amazonami/2011-09/noarch", 
        "/yumvol/amazonami/2011-09/i686", 
        "/yumvol/amazonami/2011-09/x86_64" 
        ]:
        ensure => directory,
        owner  => ec2-user,
        group  => ec2-user,
    }

}
