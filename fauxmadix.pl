#!/usr/bin/perl
# o.O <))><
# Simple HTTP server. I use it to get a canned
# xml responses with 200. Can easily be expanded to
# emulate some of the real Nomadix responses.
# The port can be overridden by passing an arg, defaults to 3001
# @CarlitosWay
# Some modules need to be installed first
# sudo apt-get install  libpoe-perl libjson-perl libpoe-component-server-http-perl
use warnings;
use strict;

use POE qw(Component::Server::TCP Filter::HTTPD);
use HTTP::Response;
use JSON;
use Data::Dumper;
my  ($help, $numRecords, $nomadixIp);
my $port = defined($ARGV[0]) ? $ARGV[0] : 3001;
my $nomadixIp = '10.200.200.100';

POE::Component::Server::TCP->new(
  Alias        => "web_server",
  Port         => $port,
  ClientFilter => 'POE::Filter::HTTPD',


  ClientInput => sub {
    my ($kernel, $heap, $request) = @_[KERNEL, HEAP, ARG0];
    print "\t\t\tGOT INPUT " . Dumper($request) . "\n";

    my $request_fields = '';
    $request->headers()->scan(
      sub {
        my ($header, $value) = @_;
        $request_fields .= "$header -> $value";
      }
    );
    print "\t\t\tRECEIVED INPUT...\n";
    my $xml = generateXml(1000)

    my $response = HTTP::Response->new(200);
    $response->push_header('Content-type', 'text/xml');
    $response->content(
      $xml
    );

    print "\t\t\tSENDING RESPONSE " . Dumper($response);
    $heap->{client}->put($response);
    $kernel->yield("shutdown");
  }
);

print "Starting HTTP Server... Listening on port $port\n";
$poe_kernel->run();
exit 0

sub generateXml {
    my ($numRecords) = @_;
    my $top = '<?xml version="1.0" encoding="UTF-8"?><NSE COMMAND="CURR_USERS_RSP">';
    my $bottom = '</NSE>';
    my $counter = 0;

    foreach my $ip(generateIps()){
        print getRow(generateMac(), $ip, $counter++, $counter +10,$counter+5,'Offline');
    }
}

sub generateMac {
    my $mac = '';
    for(my $i=0;$i<6;$i++){
        $mac .= sprintf("%02X",int(rand(255))).(($i<5)?'-':'');
    }
    $mac;
}

sub generateIps {
    my @ips;
    my $start = dq2n('172.100.100.100');
    for($start .. $start + $numRecords){
        push(@ips, n2dq($_));
    }
    @ips;
}

sub dq2n{ unpack 'N', pack 'C4', split '\.', $_[0] }
sub n2dq{ join '.', unpack 'C4', pack 'N', $_[0] }

sub getRow {
    my ($macAddress, $ipAddress, $userId, $bwUp, $bwDown, $state) = @_;
    my $row = '<SUBSCRIBER><SUB_MAC_ADDR>' . $macAddress . '</SUB_MAC_ADDR><SUB_IP>' . $ipAddress . '</SUB_IP>';
    $row .= '<LOCATION>0</LOCATION><ROOM_NUM></ROOM_NUM><USER_NAME><![CDATA[""]]>' . $userId . '</USER_NAME><BW_UP>' . $bwUp . '</BW_UP>';
    $row .= '<BW_DOWN>' . $bwDown . '</BW_DOWN><THRU_UP>0-0</THRU_UP><THRU_DOWN>0-0</THRU_DOWN><SUB_AAA_STATE>' . $state . '</SUB_AAA_STATE><EXPIRY_TIME>Unlimited</EXPIRY_TIME>';
    $row .= '<SUB_IDLE_TO>none</SUB_IDLE_TO><BYTES_TX>0</BYTES_TX><BYTES_RX>5738787</BYTES_RX><PROXY_STATE>OFF</PROXY_STATE>';
    $row .= '<NAT_IP>' . $nomadixIp . '</NAT_IP></SUBSCRIBER>';
    $row;
}
