#!/usr/bin/perl -w 

use English;

#use Data::Dump qw(dump);

my @words =();
my @pmcs_file1 =();
# my @pmcs_file2 =();
my @paperIDs;

open my $paperID, '<', 'pmcs_uniq.csv' or die $!;
while (my $read_ID=<$paperID>){
    chomp $read_ID;
    push @paperIDs,$read_ID;
}
close $paperID;

open my $pmc_year, '<', 'pmc_year.csv' or die $!;
while (my $pmc_year_line=<$pmc_year>){
    chomp $pmc_year_line;
    # push @pmc_year_lines,$pmc_year_line;
    @words = split(/,/, $pmc_year_line);
    push @pmcs_file1,$words[0];
}
close $pmc_year;

# open my $pmc_title, '<', 'pmcs_titles.csv' or die $!;
# while (my $pmc_title_line=<$pmc_title>){
#     chomp $pmc_title_line;
#     # push @pmc_title_lines,$pmc_title_line;
#     @words = split(/,/, $pmc_year_line);
#     push @pmcs_file2,$words[0];
# }
# close $pmc_title;


for ($k = 0;$k <= $#paperIDs;$k++)
{
	if (!grep( /^$paperIDs[$k]$/, @pmcs_file1)) {
  		print "$paperIDs[$k]\n"; 
		# exit;
	}
}