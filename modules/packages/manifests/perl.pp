class packages::perl inherits packages {

    package { [
                "perl-Class-Accessor",
                "perl-Crypt-Rijndael",
                "perl-Dancer",
                "perl-Dancer-Plugin-REST",
                "perl-Dancer-Plugin-Passphrase",
                "perl-Data-Structure-Util",
                "perl-IO-Socket-SSL",
                "perl-Mongoose",
                "perl-Net-OAuth2",
                "perl-Template-Toolkit",
                "perl-WWW-Salesforce",
                "perl-YAML",
                "perl-Plack-Middleware-ReverseProxy",
                "perl-Validate-Tiny",
                "perl-Net-Amazon-EC2",
                "perl-Config-INI",
                "perl-Array-Diff",
                "perl-Module-Starter",
                "perl-DateTime-Format-Strptime",
                "perl-Date-Manip",
                "perl-Time-HiRes",
                "perl-MooseX-NonMoose",
                "perl-Data-ICal",
                "perl-Date-ICal",
                "perl-Class-Accessor-Chained",
                "perltidy",
              ]:
        ensure => installed,
    }
}
