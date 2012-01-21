
define baseline::disable_user ( $username ) {

    exec { "/usr/bin/passwd -l $username":
        path => '/bin:/usr/bin',
        unless => "grep $username /etc/shadow | cut -f 2 -d : | grep ^!"
    }

    exec { "/usr/bin/chsh -s /sbin/nologin $username":
        path => '/bin:/usr/bin',
        unless => "grep $username /etc/passwd | cut -f 7 -d : | grep nologin"
    }

}
