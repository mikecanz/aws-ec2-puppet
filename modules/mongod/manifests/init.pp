class mongod {

    include yum

    package { [
                "mongo-10gen",
                "mongo-10gen-server",
                "php54-pecl-mongo",
                "perl-MongoDB",
              ]:
        ensure => installed,
    }

    service { "mongod":
        enable     => true,
        ensure     => running,
        subscribe  => Package["mongo-10gen-server"],
    }
}
