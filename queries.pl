################################
# query tester
# none-prepared version
#
# o.O <))>< 
################################
use strict;
use warnings;

use DBI;
use DBD::mysql;
use Time::HiRes qw( time );
use JSON "decode_json";
use Data::Dumper;
use Getopt::Long;

BEGIN {
  srand() if $] < 5.004;
  print "Starting ~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
}

my (%ips, $help, $loops, $interval, $numRecords, $dbh, $delete);
my ($nxIp, $inserts, $updates) = ('10.10.10.10', 0, 0);

my ($user, $password, $host, $port, $name) = $ENV{MYSQL_URL} =~ m{mysql://(.+?):(.+)\@(.+):(\d+)/(.*)};
#mysql://uRisKChBGEReS:pI3ylhfGCSFmw@172.16.30.200:3306/d2b36c92db6af49b7aa82b64e935abb84


sub main {
  my $opts = GetOptions(
    'h|help'    => \$help,
    'l|loops=s'   => \$loops,
    'i|interval=s'=> \$interval,
    'r|records=s' => \$numRecords,
    'd|delete'    => \$delete
  );

  printUsage() unless !defined $help;
  $loops = defined $loops ? $loops : 10;
  $interval = defined $interval ? $interval : 15;
  $numRecords = defined $numRecords ? $numRecords : 1000;

  $dbh = DBI->connect("DBI:mysql:database=$name;hostname=$host;port=$port;", $user, $password)
    or die "Unable to connect: $DBI::errstr\n";
  
  truncateTableFirst() if defined $delete;

  generateSessions();

  foreach my $loop (1..$loops){
    printf("Entering loop number %d with %d records\n",$loop, $numRecords);
    randomnizeSessions();
    runQueries();
    printf("Finished loop number %d. Next loop in %d seconds\n",$loop, $interval);
    sleep($interval);
  }

}

sub runQueries {
  print "Running insert and update queries...\n";
  ($inserts, $updates) = (0, 0);
  my $start = time();
  foreach my $ip(keys %ips){
    if(sessionExists($ips{$ip}->{'userId'}, $ips{$ip}->{'mac'})){
      $updates++;
      updateSession($ips{$ip});
    }else{
      $inserts++;
      insertSession($ips{$ip});
    }     
  }      
  my $end = time();
  printf("Total updates => %d, inserts => %d for %d records in that loop. Running time: %.5f\n",
    $updates, $inserts, $numRecords, $end - $start);  
}

sub sessionExists {
  my ($userId, $mac) = @_;
  my $count;
  my $q = "SELECT COUNT(*) as counter from NomadixUsers where userId = ? and macAddress = ?";
  my $prep = $dbh->prepare($q);
  $prep->execute($userId, $mac); 
  $prep->bind_col(1, \$count);
  $prep->fetch;
  $count > 0;
}

sub updateSession {
  my ($s) = @_;
  my $q = q(
    UPDATE NomadixUsers 
    SET megaBytesUp = ?, 
    megaBytesDown = ?, 
    state = ?
    where userId = ? and macAddress = ?
  );
  my $prep = $dbh->prepare($q);
  $prep->execute( $s->{'mbUp'}, $s->{'mbDown'}, $s->{'state'}, $s->{'userId'}, $s->{'mac'} );
}

sub insertSession {
  my ($s) = @_;
  my $q = q(
    INSERT INTO NomadixUsers (userId, macAddress, ipAddress, megaBytesUp, megaBytesDown, nomadixIp, state)
    VALUES (?, ?, ?, ?, ?, ?, ?)
  );
  my $prep = $dbh->prepare($q);
  $prep->execute($s->{'userId'}, $s->{'mac'}, $s->{'ip'}, $s->{'mbUp'}, $s->{'mbDown'}, $nxIp, $s->{'state'});  
}

sub generateSessions {
  print "Generating sessions...\n";
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

sub randomnizeSessions {
  foreach my $ip(keys %ips){
    $ips{$ip}->{'mbDown'}   = $ips{$ip}->{'mbDown'} + int(rand(15));
    $ips{$ip}->{'mbUp'}     = $ips{$ip}->{'mbUp'} + int(rand(10));
    $ips{$ip}->{'state'}    = randomState();
  }
}

sub truncateTableFirst {
  print "Truncating table first...\n";
  my $q = "TRUNCATE TABLE NomadixUsers";
  $dbh->do($q);
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

sub printUsage {
    print <<USAGE;

Usage: 

perl $0 [-h|--help] [-l|--loops 10] [-i|--interval 15] [-r|--records 1000] [-d|--delete]
-h   This little help text
-l   number of loops, defaults to 10
-i   seconds between loops, defaults to 15
-r   number of records or sessions to generate, defaults to 1000 and is randomly changed with each loop
-d   Delete or truncate table before start

USAGE
    exit;
}

main();

END {
    $dbh->disconnect if defined $dbh;
    print "Done\n";
}
