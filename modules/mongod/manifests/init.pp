class mongod {

    include yum

    package { [
                "mongo-10gen"
                "mongo-10gen-server",
                "php-pecl-mongo",
              ]:
        ensure => installed,
    }

    service { "mongod":
        enable     => true,
        ensure     => running,
        subscribe  => Package["mongo-10gen-server"],
    }
}
