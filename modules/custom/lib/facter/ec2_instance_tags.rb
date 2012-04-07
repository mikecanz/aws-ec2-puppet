# This fact returns a comma-separated list of all tags 
# associated with the current instance

require 'time'
cache = "/var/lib/puppet/ec2_instance_tags"

yesterday = Time.now - (60 * 60 * 24)
if File.exists?(cache) and not File.zero?(cache)
    modtime = File.mtime(cache)
else
    modtime = Time.at(0)
end

if modtime > yesterday
    # The cache file existed and was recent. 
    cfile = File.new(cache, "r")
    cfile.each do |c|
        (name, value) = c.split(/:/)
        Facter.add("ec2_instance_tag_" + name) do
            setcode do
                value
            end
        end
    end
elsif File.executable?("/usr/local/bin/fetch_ec2_tags.pl")
    # The cache file either didn't exist, or wasn't recent enough. 
    fetched = `/usr/local/bin/fetch_ec2_tags.pl`.chomp
    tags = fetched.split(/;/)
    cfile = File.new(cache, "w")

    tags.each do |x|
        cfile.write(x)
        cfile.write("\n")
        tag = Hash[*x.split(/:/)]
        tag.each do |key,value|
           Facter.add("ec2_instance_tag_" + key ) do
                setcode do
                    value
                end
            end
        end
    end
end

# The cache file does not exist, and neither does the script to fetch tags. We're done here.
