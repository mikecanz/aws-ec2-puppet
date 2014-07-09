#!/usr/bin/perl
# Print out any user-set tags for the current instance that start with puppet_

use strict;
use warnings;

use Data::Dumper;
use Net::Amazon::EC2;
use Config::INI::Reader;

exit unless -e '/opt/aws/credential-file';

my $config = Config::INI::Reader->read_file('/opt/aws/credential-file');

my $ec2 = Net::Amazon::EC2->new(AWSAccessKeyId  => $config->{'_'}->{'AWSAccessKeyId'},
                                SecretAccessKey => $config->{'_'}->{'AWSSecretKey'});

my $instance_id = `curl --silent http://169.254.169.254/latest/meta-data/instance-id`;


my $result = $ec2->describe_tags({'Filter.Name' => 'resource-id', 'Filter.Value' => $instance_id});

my $puppet_tags = "";
for my $tags (@$result) {
    my %z = %$tags;
    if ( $z{"key"} =~ /^puppet/ and $z{"value"} eq "1" ) {
        my $tag = $z{"key"};
        $tag =~ s/^puppet_//;
        $puppet_tags = $puppet_tags . $tag . ",";
    }
}

print $puppet_tags;
