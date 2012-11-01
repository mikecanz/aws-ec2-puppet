class packages::php inherits packages {

    include ::php

    package { [
                "php54-pecl-ssh2",
                "php54-xml",
                "php54-pecl-apc",
                "php54-gd",
                "php54-mcrypt",
              ]:
        ensure => installed,
    }

    package { "php54":
        ensure => "php54-5.4.7",
    }
}
