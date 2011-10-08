class ec2-metadata {

        package { "ec2-metadata":
            ensure => latest,
        }

        file { ["/opt/aws/ec2-metadata"]:
            ensure => "directory",
        }   
}
