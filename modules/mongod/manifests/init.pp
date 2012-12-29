class mongod {

    include yum

    package { [
                "mongo-10gen",
                "mongo-10gen-server",
                "php-pecl-mongo",
                "perl-MongoDB",
              ]:
        ensure => installed,
    }

    service { "mongod":
        enable     => true,
        ensure     => running,
        subscribe  => Package["mongo-10gen-server"],
    }

    file { "/etc/logrotate.d/mongodb":
        source  => "puppet:///modules/mongod/etc/logrotate.d/mongodb",
        mode    => "644",
    }
}
