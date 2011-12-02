class packages::perl-mongoose inherits packages {

    package { "perl-Mongoose":
        ensure => installed,
    }
}
