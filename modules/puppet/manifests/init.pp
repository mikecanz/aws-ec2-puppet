class puppet {
        File { owner => "root",
            group => "root",
            mode => 644,
        }

        package { "rubygem-puppet":
            ensure => latest,
        }
        
        file { "/etc/puppet/puppet.conf":
            source => "puppet:///modules/puppet/etc/puppet/puppet.conf",
            owner  => "root",
            group  => "root",
            mode   => 644,
        }

        file { "/etc/cron.d/puppet":
                source => "puppet:///modules/puppet/etc/cron.d/puppet.cron",
                notify => Service["crond"],
        }
}
