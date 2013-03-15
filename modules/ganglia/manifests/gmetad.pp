class ganglia::gmetad {

    package { [
                "ganglia",
                "ganglia-gmetad",
              ]:
        ensure => installed,
    }

    service { "gmetad":
        enable     => true,
        ensure     => running,
    }

    file { [
        "/var/lib/ganglia/rrds",
        ]:
        ensure => directory,
        owner  => nobody,
        group  => nobody,
    }
}
