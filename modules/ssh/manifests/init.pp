class ssh {

        file { "/etc/ssh/ssh_config":
            source => "puppet:///modules/ssh/etc/ssh/ssh_config",
        }

}
