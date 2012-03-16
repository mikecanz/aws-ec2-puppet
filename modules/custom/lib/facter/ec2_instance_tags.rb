# This fact returns a comma-separated list of all tags 
# associated with the current instance

if File.executable?("/usr/local/bin/fetch_ec2_tags.pl")
    fetched = `/usr/local/bin/fetch_ec2_tags.pl`.chomp
    tags = fetched.split(/;/)
else
    tags = ""
end

if tags

    tags.each do |x|
        tag = Hash[*x.split(/:/)]
        tag.each do |key,value|
           Facter.add("ec2_instance_tag_" + key ) do
                setcode do
                    value
                end
            end
        end
    end

else

    return 

end
