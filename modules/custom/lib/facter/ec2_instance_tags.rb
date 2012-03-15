# This fact returns a comma-separated list of all tags 
# associated with the current instance

Facter.add("ec2_instance_tags") do
    setcode do
        if File.executable?("/usr/local/bin/fetch_ec2_tags.pl")
            result = `/usr/local/bin/fetch_ec2_tags.pl`
        else
            result = False
        end
        result
    end
end
