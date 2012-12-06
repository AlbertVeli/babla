#!/usr/bin/env perl

if ($#ARGV < 0) {
    print "no word given\n";
    exit;
}

$word = $ARGV[0];
# states:
# 0 = waiting for "##\s*$word\s*{"
# 1 = waiting for "^$word\s*{"
# 2 = print next line that is not empty
#     and set state to 1
$state = 0;

while (defined($line = <STDIN>)) {
    if ($state == 0) {
	if ($line =~ m/##\s*$word\s*{/) {
	    $state = 1;
	}
    } elsif ($state == 1) {
	if ($line =~ m/^$word\s*{/) {
	    $state = 2;
	}
    } elsif ($state == 2) {
	if ($line =~ m/.*{/) {
	    print $line;
	    $state = 1;
	}
    }
}
