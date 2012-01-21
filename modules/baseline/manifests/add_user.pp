
define baseline::add_user ( $uid ) {

    File { owner => $name, group => $name, mode => 644, }

    user { $name:
            home     => "/home/$name",
            shell    => "/bin/bash",
            uid      => $uid,
            gid      => $uid,
            password => template("passwords/$name"),
    }

    group { $name:
            gid     => $uid,
    }

    file { "/home/$name/":
            ensure  => directory,
            require => [ User[$name], Group[$name] ],
    }

    file { "/home/$name/.ssh":
            ensure  => directory,
            mode    => 700,
    }

    # now make sure that the ssh key authorized files is around
    file { "/home/$name/.ssh/authorized_keys":
            ensure  => present,
            mode    => 600,
    }

}
