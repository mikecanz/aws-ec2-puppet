
class packages {

    include yum

    @package { "perl-DBD-MySQL":
        ensure => installed,
    }
}
