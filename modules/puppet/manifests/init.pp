class puppet {

        $minute = fqdn_rand(60)

        File { 
            owner => "root",
            group => "root",
            mode => 644,
        }

        include baseline

        package { "puppet":
            ensure => latest,
        }
        
        file { "/etc/puppet/puppet.conf":
            source => "puppet:///modules/puppet/etc/puppet/puppet.conf",
        }

        file { "/etc/cron.d/puppet":
                content => template("puppet/etc/cron.d/puppet.cron.erb"),
                notify => Service["crond"],
        }

}
