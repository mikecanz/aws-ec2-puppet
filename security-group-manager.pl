#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use Net::Amazon::EC2;
use Config::INI::Reader;
use Array::Diff;
use DateTime;
use DateTime::Format::Strptime;

my $config = Config::INI::Reader->read_file('/opt/aws/credential-file');

my $ec2 = Net::Amazon::EC2->new(AWSAccessKeyId  => $config->{'_'}->{'AWSAccessKeyId'},
                                SecretAccessKey => $config->{'_'}->{'AWSSecretKey'});

my $instances       = $ec2->describe_instances();
my $ip_to_group_map = ip_to_group_mapping();

#########################################
# This section if for specific policies #
#########################################
#set_allowed_ips(['mongodb-devserver'], 'test-group', 4730);
#set_allowed_ips(['mongodb-webserver'], 'test-group', 80);

set_allowed_ips(['v1-gearman-worker-nodejs-dev'], 'v1-gearman-master-dev',        4730);
set_allowed_ips(['v1-gearman-master-dev'],        'v1-gearman-worker-nodejs-dev', 4730);

set_allowed_ips(['v1-gearman-worker-nodejs-prod'], 'v1-gearman-master-prod',        4730);
set_allowed_ips(['v1-gearman-master-prod'],        'v1-gearman-worker-nodejs-prod', 4730);

# This policy is for the nodejs worker sever to talk to MongoDB directly.  It will go away.
set_allowed_ips(['admin','v1-gearman-worker-nodejs-prod'], 'v1-db-mongo-prod', 27017);

#######################################
# This section is for global policies #
#######################################
my @all_groups = get_all_security_groups();

# We want all our servers to be able to talk to the yum server
# Many to one
set_allowed_ips(\@all_groups, 'v1-yum-master-prod', 80);

# We want the admin server to be able to talk to all other servers over ssh
# One to many
map { set_allowed_ips(['admin'], $_, 22); } @all_groups;

#map { set_allowed_ips(['v1-admin'], $_, 22); } @all_groups;

###################
# Supporting subs #
###################
sub set_allowed_ips
{
    my $source_groups     = shift;
    my $destination_group = shift;
    my $port              = shift;

    # Needs to pass the security group of the gearmand server
    my $source_ips = get_source_ips($source_groups);

    # Needs to be the security group of the worker nodes.
    my $existing_ips = get_existing_ip_list($destination_group, $port);

    my $diff = Array::Diff->diff($existing_ips, $source_ips);

    #print Dumper $diff;

    foreach my $ip (@{$diff->{added}}) {
        my $dt           = DateTime->now;
        my $time         = $dt->datetime();
        my $source_group = $ip_to_group_map->{$ip};

        print "$time - Add $ip:$port ($source_group) to the $destination_group security group\n";
        my $params = {
                      GroupName  => $destination_group,
                      IpProtocol => 'tcp',
                      FromPort   => $port,
                      ToPort     => $port,
                      CidrIp     => "$ip/32",
                     };
        $ec2->authorize_security_group_ingress($params);
    }

    foreach my $ip (@{$diff->{deleted}}) {
        my $dt           = DateTime->now;
        my $time         = $dt->datetime();
        my $source_group = $ip_to_group_map->{$ip} || 'Terminated';

        print "$time - Remove $ip:$port ($source_group) from the $destination_group security group\n";
        my $params = {
                      GroupName  => $destination_group,
                      IpProtocol => 'tcp',
                      FromPort   => $port,
                      ToPort     => $port,
                      CidrIp     => "$ip/32",
                     };
        $ec2->revoke_security_group_ingress($params);
    }
}

sub get_all_security_groups
{
    my $security_groups = $ec2->describe_security_groups();
    return map { $_->group_name } @{$security_groups};
}

sub ip_to_group_mapping
{
    my $map;
    foreach my $reservation_info (@{$instances}) {
        my @groups = map { $_->{group_name} } @{$reservation_info->{group_set}};

        # If an instance is terminated but not cleaned up it may still show up
        if (defined $reservation_info->{instances_set}[0]->{private_ip_address}) {
            $map->{$reservation_info->{instances_set}[0]->{private_ip_address}} = join(',', @groups);
        }
    }
    return $map;
}

sub get_existing_ip_list
{
    my @existing_group_ips;
    my $security_group_name = shift;
    my $port                = shift;
    my $security_group      = $ec2->describe_security_groups({'GroupName' => $security_group_name});

    foreach my $rule (@{$security_group->[0]->{ip_permissions}}) {
        if ($rule->{from_port} eq $port) {
            foreach my $range (@{$rule->{ip_ranges}}) {
                my @ip = split('/', $range->{cidr_ip});
                if ($ip[0] ne '0.0.0.0' && $ip[0] ne '127.0.0.1') {
                    push(@existing_group_ips, $ip[0]);
                }
            }
        }
    }
    @existing_group_ips = sort @existing_group_ips;
    return \@existing_group_ips;
}

sub get_source_ips
{
    my $security_group_names = shift;
    my @servers_with_group;

    foreach my $reservation_info (@{$instances}) {
        if (defined $reservation_info->{instances_set}[0]->{private_ip_address}) {
            foreach my $group (@{$reservation_info->{group_set}}) {
                if (grep(/^$group->{group_name}$/, @{$security_group_names})) {
                    push(@servers_with_group, $reservation_info->{instances_set}[0]->{private_ip_address});
                }
            }
        }
    }

    # We do this to eliminate IPs that have multiple security groups and
    # thus might show up twice.  So this is the perl way of doing a unique
    # on an array.
    my %hashTemp = map { $_ => 1 } @servers_with_group;
    @servers_with_group = sort keys %hashTemp;
    return \@servers_with_group;
}
