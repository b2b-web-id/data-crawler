#!/usr/bin/perl

my $q = "";
foreach $arg ( 0 .. $#ARGV ) { 
 $q = $q . " " . $ARGV[$arg];
};

# URL
my $url = "https://ajax.googleapis.com/ajax/services/search/web?v=1.0&rsz=8&q=".$q;

use LWP::UserAgent;
use JSON;

my $ua = LWP::UserAgent->new();
#$ua->default_header("HTTP_REFERER" => '');
my $body = $ua->get($url);

my $json = from_json($body->decoded_content);

my $p = 0;
my $i = 0;
foreach my $page (@{$json->{responseData}->{cursor}->{pages}}) {
 $p++;
 #print "Halaman \#". $page->{label} . "\n";
 my $fetch = $url . "&start=" . $page->{start};

 my $cbody = $ua->get($fetch);
 my $cjson = from_json($cbody->decoded_content);

 foreach my $result (@{$cjson->{responseData}->{results}}) {
  $i++;
  print $i. ". " . $result->{titleNoFormatting} . " - ". $result->{url} . "\n";
 };
 if (!$i) { print "no result!"; };
};
if (!$p) { print "no result!"; };

