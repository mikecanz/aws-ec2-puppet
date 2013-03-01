
class packages {

    include yum

    @package { "perl-DBD-MySQL":
        ensure => installed,
    }

    package { ["pdfjam", "poppler-utils"]:
        ensure => installed,
    }
}
