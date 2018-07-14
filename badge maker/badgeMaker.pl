#!/usr/bin/perl -w

# (1) quit unless we have the correct number of command-line args
$num_args = $#ARGV + 1;
if ($num_args != 2) {
    print "\nInvalid number of arguments. Usage: badgeMaker.pl badge issuer\n";
    exit;
}
# (2) we got three command line args
$badgeName=$ARGV[0];
$issuerName=$ARGV[1];

# Test, pls ignore
# $badgeName="test - Copy";
# $issuerName="Max";

$templateFileName=$badgeName . '.svg';
$badgeFileName=$issuerName . '_' . $badgeName . '.svg';
open(my $templateFile, '<', $templateFileName)
    or die "Unable to open file, $!";
open(my $badgeFile, '>', $badgeFileName)
	or die "Unable to open file, $!";
while (<$templateFile>) { # Read the file line per line
	s/ISSUER/$issuerName/ee;
	print $badgeFile $_;
   # last if $_ eq 'banana'; # Leave the while-loop.
}