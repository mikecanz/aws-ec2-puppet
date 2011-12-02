class packages::perl-net-oauth2 inherits packages {

    package { "perl-Net-OAuth2":
        ensure => installed,
    }
}
