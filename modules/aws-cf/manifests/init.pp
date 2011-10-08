class aws-cf {

        package { "AWSCloudFormation":
            ensure => latest,
        }

        file { ["/opt/aws/AWSCloudFormation"]:
            ensure => "directory",
        }

}
