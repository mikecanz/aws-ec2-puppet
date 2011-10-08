class ec2-api-tools {

        package { "ec2-api-tools":
            ensure => latest,
        }

        file { ["/opt/ec2-certs"]:
            ensure => "directory",
        }

}
