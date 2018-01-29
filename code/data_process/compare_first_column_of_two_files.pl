#!/usr/bin/perl -w 

use English;

#use Data::Dump qw(dump);

my @words =();
my @pmids_file1 =();
my @pmids_file2 =();
# my @paperIDs;

# open my $paperID, '<', 'paperID_uniq.csv' or die $!;
# while (my $read_ID=<$paperID>){
#     chomp $read_ID;
#     push @paperIDs,$read_ID;
# }
# close $paperID;

open my $pmid_year, '<', 'pmid_year_processed.csv' or die $!;
while (my $pmid_year_line=<$pmid_year>){
    chomp $pmid_year_line;
    # push @pmid_year_lines,$pmid_year_line;
    @words = split(/,/, $pmid_year_line);
    push @pmids_file1,$words[0];
}
close $pmid_year;

open my $pmid_title, '<', 'pmids_titles.csv' or die $!;
while (my $pmid_title_line=<$pmid_title>){
    chomp $pmid_title_line;
    # push @pmid_title_lines,$pmid_title_line;
    @words = split(/,/, $pmid_title_line);
    push @pmids_file2,$words[0];
}
close $pmid_title;


for ($k = 0;$k <= $#pmids_file1;$k++)
{
	if (!grep( /^$pmids_file1[$k]$/, @pmids_file2 )) {
  		print "$pmids_file1[$k]\n"; 
		exit;
	}
}