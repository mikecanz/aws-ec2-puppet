# Write out the cached ec2_instance_id value if it doesn't exist already
# Return the cached value if it does

Facter.add("ec2_instance_id_cached") do

    cfile = "/var/lib/puppet/ec2_instance_id"

    if File.exists?(cfile) and not File.zero?(cfile)

        cache = File.new(cfile, "r")
        cache.each do |c|
            setcode do
                c.chomp
            end
        end

    else

        ec2_instance_id = Facter.value(:ec2_instance_id)
        File.open(cfile, "w") do |c|
            c.write(ec2_instance_id)
        end
        setcode do
            ec2_instance_id
        end

    end

end
