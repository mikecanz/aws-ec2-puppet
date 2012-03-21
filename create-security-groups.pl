#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use Net::Amazon::EC2;
use Config::INI::Reader;
use Array::Diff;

my $config = Config::INI::Reader->read_file('/opt/aws/credential-file');

my $ec2 = Net::Amazon::EC2->new(AWSAccessKeyId  => $config->{'_'}->{'AWSAccessKeyId'},
                                SecretAccessKey => $config->{'_'}->{'AWSSecretKey'});

create_security_group('v1-webserver-nginx-dev', 'Dev nginx server');
add_default_ingress('v1-webserver-nginx-dev', 80,  '0.0.0.0/0');
add_default_ingress('v1-webserver-nginx-dev', 443, '0.0.0.0/0');
add_default_ingress('v1-webserver-nginx-dev', 22,  '0.0.0.0/0');

create_security_group('v1-webserver-nginx-prod', 'Prod nginx server');
add_default_ingress('v1-webserver-nginx-prod', 80,  '0.0.0.0/0');
add_default_ingress('v1-webserver-nginx-prod', 443, '0.0.0.0/0');

create_security_group('v1-webserver-httpd-dev', 'Dev httpd server');
add_default_ingress('v1-webserver-httpd-dev', 80,  '0.0.0.0/0');
add_default_ingress('v1-webserver-httpd-dev', 443, '0.0.0.0/0');
add_default_ingress('v1-webserver-httpd-dev', 22,  '0.0.0.0/0');

create_security_group('v1-webserver-httpd-prod', 'Prod httpd server');
add_default_ingress('v1-webserver-httpd-prod', 80,  '0.0.0.0/0');
add_default_ingress('v1-webserver-httpd-prod', 443, '0.0.0.0/0');

create_security_group('v1-gearman-worker-nodejs-dev', 'Dev Gearman worker server');
add_default_ingress('v1-gearman-worker-nodejs-dev', 22, '0.0.0.0/0');

create_security_group('v1-gearman-worker-nodejs-prod', 'Prod Gearman worker server');

create_security_group('v1-gearman-master-dev', 'Dev Gearman master server');
add_default_ingress('v1-gearman-master-dev', 22, '0.0.0.0/0');

create_security_group('v1-gearman-master-prod', 'Prod Gearman master server');

create_security_group('v1-db-mysql-dev', 'Dev mysql server');
add_default_ingress('v1-db-mysql-dev', 22, '0.0.0.0/0');

create_security_group('v1-db-mysql-prod', 'Prod mysql server');

create_security_group('v1-db-mongo-dev', 'Dev mongodb server');
add_default_ingress('v1-db-mongo-dev', 22, '0.0.0.0/0');

create_security_group('v1-db-mongo-prod', 'Prod mongodb server');

create_security_group('v1-yum-master-prod', 'Prod yum server');

create_security_group('v1-build-master-prod', 'Prod build server');

create_security_group('v1-admin', 'Prod yum server');

sub create_security_group
{
    my $name = shift;
    my $desc = shift;

    my $params = {
                  GroupName        => $name,
                  GroupDescription => $desc,
                  ,
                 };

    my $result = $ec2->create_security_group($params);
}

sub add_default_ingress
{
    my $destination_group = shift;
    my $port              = shift;
    my $ip                = shift;

    my $params = {
                  GroupName  => $destination_group,
                  IpProtocol => 'tcp',
                  FromPort   => $port,
                  ToPort     => $port,
                  CidrIp     => "$ip",
                 };
    $ec2->authorize_security_group_ingress($params);
}
