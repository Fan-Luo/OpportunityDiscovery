#!/usr/bin/perl -w 

use English;

$result_file = "pmid_year_processed.csv";    #no duplicates, no mismatch (if there are more than one "year" for same pmid, use the most frequent)
open(OUTPUT, ">$result_file") || die "Cannot open file $result_file for writing\n";
print OUTPUT "pmid,year\n";

my %h=();

open(my $fh, '<', 'pmid_year.csv') or die "Can't read file\n";
readline $fh;    # skip the first line 
while (my $line = <$fh>) {
    chomp $line;
	my @pmid_year = split(/,/, $line);
	my $pmid = $pmid_year[0];
    my $year = $pmid_year[1];
    if(exists $h{$pmid} && exists $h{$pmid}{$year}){    #nested hash
    		$h{$pmid}{$year}++;      #counter
    }
    else{
        $h{$pmid}{$year} = 1; 
    }
}
close $fh;

my @pmids = ();
while( my($pmid, $years) = each %h ){ 
    # my $years = $h{$pmid};
    my $frequent_year;
    my @key = sort { ${$years}{$b} <=> ${$years}{$a}} keys %{$years};   #%{$years}: hash reference
    $frequent_year = $key[0];  
    print OUTPUT "$pmid,$frequent_year\n";
}

