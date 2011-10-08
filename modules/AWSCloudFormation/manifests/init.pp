class AWSCloudFormation {

        package { "AWSCloudFormation":
            ensure => latest,
        }

        file { ["/opt/AWSCloudFormation"]:
            ensure => "directory",
        }

}
