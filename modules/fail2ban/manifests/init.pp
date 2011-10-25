class fail2ban {
    include baseline

    package { "fail2ban":
        ensure => latest,
    }
        
}
