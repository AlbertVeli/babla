#!/usr/bin/env perl

if ($#ARGV < 0) {
    print "no word given\n";
    exit;
}

$word = $ARGV[0];

$state = 0;

while (defined($line = <STDIN>)) {
    if ($state == 0) {
	# Search for line starting with ## word
	if ($line =~ m/^#+\s*$word/i) {
	    $state = 1;
	}
    } elsif ($state == 1) {
	# Print lines beginning with a number
	# Could stop printing when getting a non-empty line
	# not matching the rule. But skip that for now.
	if ($line =~ m/^\d+\s+/) {
	    print $line;
	}
    }
}
