#!/usr/bin/perl
# Print out any user-set tags for the current instance

use strict;
use warnings;

use Data::Dumper;
use Net::Amazon::EC2;
use Config::INI::Reader;

my $config = Config::INI::Reader->read_file('/opt/aws/credential-file');

my $ec2 = Net::Amazon::EC2->new(AWSAccessKeyId  => $config->{'_'}->{'AWSAccessKeyId'},
                                SecretAccessKey => $config->{'_'}->{'AWSSecretKey'});

chomp(my $instance_id = `facter ec2_instance_id_cached`);

my $result = $ec2->describe_tags({'Filter.Name' => 'resource-id', 'Filter.Value' => $instance_id});


for my $tags (@$result) {
    my %z = %$tags;
    print $z{"key"} . ":" . $z{"value"} . ",";
}
