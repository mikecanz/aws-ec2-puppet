class packages::perl inherits packages {

    package { [
                "perl-Class-Accessor",
                "perl-Crypt-Rijndael",
                "perl-Data-Structure-Util",
                "perl-IO-Socket-SSL",
                "perl-Mongoose",
                "perl-Template-Toolkit",
                "perl-WWW-Salesforce",
                "perl-YAML",
                "perl-Validate-Tiny",
                "perl-Net-Amazon-EC2",
                "perl-Config-INI",
                "perl-Array-Diff",
                "perl-Module-Starter",
                "perl-DateTime-Format-Strptime",
                "perl-Date-Manip",
                "perl-Date-Calc",
                "perl-Time-HiRes",
                "perl-MooseX-NonMoose",
                "perl-Data-ICal",
                "perl-Date-ICal",
                "perl-Class-Accessor-Chained",
                "perl-Filesys-Notify-Simple",
                "perl-DBI",
                "perl-Email-Stuff",
                "perl-Module-List",
                "perl-Module-Runtime",
                "perl-Module-Util",
                "perl-LWP-Curl",
                "perl-Test-WWW-Mechanize",
                "perl-Time-Duration",
                "perl-Time-Duration-Parse",
                "perl-Geo-StreetAddress-US",
                "perltidy",
                "perl-LockFile-Simple",
                "perl-HTML-HTMLDoc",
                "perl-String-Compare",
                "perl-File-Slurp",
                "perl-File-Slurp-Unicode",
                "perl-Data-Printer",
                "perl-Business-US-USPS-WebTools",
                "perl-Text-JaroWinkler",
                "perl-Getopt-Long-Descriptive",
                "perl-XML-Twig",
                "perl-Text-CSV",
                "perl-Lingua-EN-NameParse",
                "perl-Lingua-EN-AddressParse",
                "perl-List-Compare",
                "perl-Lingua-EN-Words2Nums",
                "htmldoc",
              ]:
        ensure => installed,
    }

    package { [
                "perl-Term-ANSIColor",
              ]:
        ensure => latest,
    }

    realize Package["perl-DBD-MySQL"]
}
