#!/usr/bin/perl
use strict;
use warnings;

use constant false => 0;
use constant true  => 1;

my $SUSPFLAG=false;
my $HomeDir=$ENV{'HOME'};
my $SUSPFILE="$HomeDir/.mondropbox/mondropbox.disable";
my $DEBUG=0;

#$SIG{'USR2'} = 'SignalDisable'; #suspend signal  12
#$SIG{'USR1'} = 'SignalEnable'; #suspend signal  10    

#sub SignalDisable {
	
	#$SUSPFLAG= true;

	#system("notify-send \"Dropbox Monitor\" \"Suspending...!\""); 
	
#}

#sub SignalEnable {
	
	#$SUSPFLAG= false;

	#system("notify-send \"Dropbox Monitor\" \"Resuming...!\""); 
	
#}

#Reset run apps status

unlink($SUSPFILE);

my $isrunning=`ps -ef | grep -E mondropbox.pl\$ | wc -l`;
my $outrunning=`ps -ef | grep -E mondropbox.pl\$`;
if ( $isrunning > 1 ) {
	print "Already running. Aborting...\n";
	system("notify-send \"Dropbox!\" \"Already running. Quiting!\"");
	exit 2;
}

my $desktopfinal="$HomeDir/.local/share/applications/mondropbox.desktop";
if ( ! -f $desktopfinal ) {
	print "No desktop shortcut. Run $HomeDir/.mondropbox/setup.sh\n";
	exit (255);
}
system("sed -i 's/Icon=dropboxoff/Icon=dropbox/' $desktopfinal;touch $desktopfinal");

print "Initiating grace period...\n";

if (not $DEBUG) { sleep(120); }
my $startflag=0;
my $stat=""; 
my $last_msg="";
my $cont=0;
print "Initiating watchdog...\n";
system("bash $HomeDir/.mondropbox/mondropbox_cmd.sh on");
for(;;){
		
	
	if ( -f $SUSPFILE) {
			
			sleep (10);
			next;
	}
	
	$stat=`dropbox status`; 
	chomp($stat);
	if ($DEBUG) {print "DEBUG: $stat\n";}
	if ( ($stat eq "Dropbox isn't running!" || $stat =~ m/Connecting/)  && $startflag == 0 ) {
		system("notify-send \"Dropbox!\" \"$stat!\"");
		$startflag++;
		sleep(180);
		next;
	}
	elsif ( ($stat eq "Dropbox isn't running!" || $stat eq "Connecting...") && $startflag == 1 ) {
		
		
			system("notify-send \"Dropbox!\" \"Still down. Restarting...!\"");
			system("dropbox stop");
			sleep(2);
			system("killall dropbox");
			sleep (3);
			system("bash $HomeDir/bin/Dropbox.sh");
			$startflag++;
			sleep (180);
		
	}
	elsif ( ($stat eq "Dropbox isn't running!" || $stat eq "Connecting...") && $startflag == 2 ) {
		system("notify-send \"Dropbox!\" \"Still down. Suspending ...!\"");
		system("$HomeDir/.mondropbox/mondropbox_cmd.sh off");
		$startflag=0;
		next;
	}
	elsif ( $stat ne $last_msg && $cont == 1 && $stat ne "Up to date" ) {
		system("notify-send \"Dropbox\" \"$stat\"");
		sleep(18);
	}
	
	$last_msg=$stat;
	
	if ($cont == 0) { $cont=1;}
	
	if ( $DEBUG) {	print "Sleeping\n";}
	sleep(10);
}
