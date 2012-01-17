
class nodejs {

    include yum

    package { "nodejs":
        ensure => installed,
    }

}
