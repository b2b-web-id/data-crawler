#!/usr/bin/perl

use open ':std', ':encoding(UTF-8)';
use strict;
use warnings;
use Net::Twitter;
use Scalar::Util 'blessed';
use Data::Dumper;
use Getopt::Long;

my $terms = "";
foreach $na ( 0 .. $#ARGV ) {
 $terms = $terms . " " . $ARGV[$na];
}

my $key = '';
my $secret = '';
my $token = '';
my $token_secret = '';

my $nt = Net::Twitter->new(
      traits              => [qw/API::RESTv1_1/],
      consumer_key        => $key,
      consumer_secret     => $secret,
      access_token        => $token,
      access_token_secret => $token_secret,
      ssl                 => 1,
  );

sub print_post {
 my $t = shift @_;
 printf("%s (on %s)\n\t%s\n", $t->{user}{screen_name}, $t->{created_at}, $t->{text});
}

my $r = $nt->search($terms);
foreach my $e (@{ $r->{statuses} }) {
	print_post($e);
}
