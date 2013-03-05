class php {

        File { 
            owner   => "root", 
            group   => "root", 
            mode    => 644,
            require => Package["php"], # php package creates the initial php.ini
        }

        file { "/etc/php.ini":
            content => template("php/etc/php.ini.erb"),
        }
}
