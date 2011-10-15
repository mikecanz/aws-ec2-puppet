class libssh2 {
    package { ["libssh2", "libssh2-devel"]:
        ensure => installed,
    }
}
