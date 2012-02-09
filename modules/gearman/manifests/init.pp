
class gearman {

    include yum

    package { "perl-Gearman":
        ensure => installed,
    }

}
