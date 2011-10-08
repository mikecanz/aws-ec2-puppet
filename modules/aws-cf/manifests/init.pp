class aws-cf {

        package { "AWSCloudFormation":
            ensure => latest,
        }

        file { ["/opt/AWSCloudFormation"]:
            ensure => "directory",
        }

}
