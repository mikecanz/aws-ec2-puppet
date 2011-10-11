class ec2-api-tools {

        package { "ec2-api-tools":
            ensure => latest,
        }

        file { ["/opt/aws", "/opt/aws/ec2-api-tools"]:
            ensure => "directory",
        }   
}
