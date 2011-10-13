class git {
    File { 
        owner => "root",
        group => "root",
        mode => 644,
    }

    include baseline

    package { "git":
        ensure => latest,
    }
        
}
