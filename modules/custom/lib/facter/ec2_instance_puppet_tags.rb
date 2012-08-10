# This fact returns a comma-separated list of all puppet tags 
# associated with the current instance

require 'time'
cache = "/var/lib/puppet/ec2_instance_puppet_tags"

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
        Facter.add("ec2_instance_puppet_tags") do
            setcode do
                c
            end
        end
    end
elsif File.executable?("/usr/local/bin/fetch_ec2_puppet_tags.pl")
    # The cache file either didn't exist, or wasn't recent enough. 
    fetched = `/usr/local/bin/fetch_ec2_puppet_tags.pl`.chomp
    cfile = File.new(cache, "w")

    cfile.write(fetched)
    cfile.write("\n")
    Facter.add("ec2_instance_puppet_tags" ) do
        setcode do
            fetched
        end
    end
end

# The cache file does not exist, and neither does the script to fetch tags. We're done here.
