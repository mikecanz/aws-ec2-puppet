# Determine if this machine is "dev" or "prod"
# We currently short-circuit 'virtualbox' == 'vagrant' == 'dev'

Facter.add("is_dev") do

    setcode do

        # default to false, that is, prod
        result = "false"

        if Facter.value(:virtual) == "virtualbox"
            result = "true"
        elsif Facter.value(:ec2_instance_puppet_tags) =~ /dev/
            result = "true"
        end

        result

    end

end
