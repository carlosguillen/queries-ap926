# query tester
use strict;
use warnings;

#use DBI;
#use DBD::mysql;
#use JSON "decode_json";
use Data::Dumper;

BEGIN {
  srand() if $] < 5.004;
}

my $numRecords = 1000;
my (%ips);

my ($user, $password, $host, $port, $name) = $ENV{MYSQL_URL} =~ m{mysql://(.+?):(.+)\@(.+):(\d+)/(.*)};
#mysql://uRisKChBGEReS:pI3ylhfGCSFmw@172.16.30.200:3306/d2b36c92db6af49b7aa82b64e935abb84
#my $dbh;

sub main {
  #$dbh = DBI->connect("DBI:mysql:database=$name;hostname=$host;port=$port;", $user, $password)
  #  or die "Unable to connect: $DBI::errstr\n";
  generateUsers();

}

sub generateUsers {
    my ($numRecords) = @_;
    generateRecords();
    foreach my $ip(keys %ips){
        print "$ip, $ips{$ip}->{'mac'}, $ips{$ip}->{'userId'}, $ips{$ip}->{'mbDown'}, $ips{$ip}->{'mbUp'}, $ips{$ip}->{'state'}\n";
          #(generateMac(), $ip, $counter++, $counter +10,$counter+5,'Offline')
    }
}

sub updateOrInsert {
  my ($object) =  @_;
  if(recordExist > 1){

  }else

  }
}

sub recordExists {
  my ($userId, $mac) = @_;
  my $q = "SELECT COUNT(*) from NomadixUsers where userId = ? and macAddress = ?";
  my $prep = $dbh->prepare($q);
  $prep->execute($object->{'userId'}, $object->{'mac'});
  my $count;
  $prep->bind_columns($count);
  $count;
}

sub updateRecord {
  my ($userId, $mac) = @_;
  my $q = "SELECT COUNT(*) from NomadixUsers where userId = ? and macAddress = ?";
  my $prep = $dbh->prepare($q);
  $prep->execute($object->{'userId'}, $object->{'mac'});
  #if($prep->fetchrow)
}

sub insertRecord {
  my ($userId, $mac) = @_;
  my $q = "SELECT COUNT(*) from NomadixUsers where userId = ? and macAddress = ?";
  my $prep = $dbh->prepare($q);
  $prep->execute($object->{'userId'}, $object->{'mac'});
  #if($prep->fetchrow)
}

sub getRow {
    my (@vals) = @_;
    print join(" --- ", @vals),"\n";
}

sub generateRecords {
    my $start = dq2n('172.100.100.100');
    my $countr = 0;
    for($start .. $start + $numRecords){
        $countr++;
        my $ip = n2dq($_);
        $ips{$ip}->{'ip'} = $ip;
        $ips{$ip}->{'mac'} = generateMac();
        $ips{$ip}->{'userId'} = $countr;
        $ips{$ip}->{'mbDown'} = $countr;
        $ips{$ip}->{'mbUp'} = $countr;
        $ips{$ip}->{'state'} = randomState();
    }
}

sub randomnizeStateAndMegs {
  foreach my $ip(keys %ips){
        $ips{$ip}->{'mbDown'} = $countr + int(rand(15));
        $ips{$ip}->{'mbUp'} = $countr + int(rand(10));
        $ips{$ip}->{'state'} = randomState();
    }
}

sub generateMac {
    my $mac = '';
    for(my $i=0;$i<6;$i++){
        $mac .= sprintf("%02X",int(rand(255))).(($i<5)?'-':'');
    }
    $mac;
}

sub randomState {
  my @states = ("Valid","Pending","Offline");
  sprintf("%s",$states[int(rand(3))]);
}

sub dq2n{ unpack 'N', pack 'C4', split '\.', $_[0] }
sub n2dq{ join '.', unpack 'C4', pack 'N', $_[0] }

main();

END {
    #$dbh->disconnect;
    print "Done\n";
}
