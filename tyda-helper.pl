#!/usr/bin/env perl

if ($#ARGV < 0) {
    print "no word given\n";
    exit;
}

$word = $ARGV[0];

$state = 0;
$first = 1;

while (defined($line = <STDIN>)) {
    if ($state == 0) {
	if ($line =~ m/Översättning/i) {
	    $state = 1;
	}
    } elsif ($state == 1) {
	if ($line =~ m/Diskutera/i) {
	    $state = 2;
	    exit(0);
	} elsif ($line =~ m/Visa fler betydelser/i) {
	    $state = 2;
	    exit(0);
	} else {
	    if ($line !~ m/^\s*$/) {
		if ($line !~ m/Visa bild/i) {
		    # print non-empty lines, except the first one
		    if ($first) {
			$first = 0;
		    } else {
			if ($line !~ m/Beskrivning, synonymer/) {
			    print $line;
			}
		    }
		}
	    }
	}
    }
}
