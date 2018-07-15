#!/usr/bin/perl -w

# quit unless we have the correct number of command-line args
$num_args = $#ARGV + 1;
if ($num_args != 2 && $num_args != 3) {
    print "\nInvalid number of arguments. Usage: badgeMaker.pl badge issuer stars\n";
    exit;
}
$badgeName = $ARGV[0];
$issuerName = $ARGV[1];
$badgeStars = ($num_args == 3) ? $ARGV[2] : 0;

#-------------- CONFIG VARIABLES --------------
$size = 42;
$defaultCenterX = 64.840622;
$defaultCenterY = 62.7;
$defaultOffset = 24.65;
$offsetPerChar = 0.69;
#----------------------------------------------

$centerX = $defaultCenterX - $size;
$centerY = $defaultCenterY;
$offset = $defaultOffset - $offsetPerChar*length($issuerName);
$sizeDouble = $size*2;

# I/O
$templateFileName = 'badgeTemplates/' . $badgeName . $badgeStars . '.svg';
print($templateFileName);
$badgeFileName = $issuerName . '_' . $badgeName . '.svg';
print($badgeFileName);
open(my $templateFile, '<', $templateFileName)
    or die "Unable to open file $templateFileName, $!";
open(my $badgeFile, '>', $badgeFileName)
	or die "Unable to open file, $!";
open(my $issuerFile, '<', 'issuerTemplate/issuer.svg')
	or die "Unable to open file, $!";

# Create New Badge
while (<$templateFile>) { # Read the file line per line
	s/<\/svg>//ee;
	print $badgeFile $_;
}
$issuerName = uc $issuerName;
print($issuerName);
while (<$issuerFile>) { # Read the file line per line
	s/issuerName/$issuerName/g;
	s/centerX/$centerX/g;
	s/centerY/$centerY/g;
	s/offsetValue/$offset/g;
	if(m/d=/){
		s/sizeDouble/$sizeDouble/g;
		s/size/$size/g;
	}
	print $badgeFile $_;
}
print $badgeFile "<\/svg>";
