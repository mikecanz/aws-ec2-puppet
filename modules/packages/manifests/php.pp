class packages::php inherits packages {

    include php

    package { [
                "php",
                "php-pecl-ssh2",
              ]:
        ensure => installed,
    }
}
