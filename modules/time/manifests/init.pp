
class time {

    file { "/etc/localtime":
            ensure => "/usr/share/zoneinfo/EST5EDT",
            notify => Service["crond"],
    }

}
