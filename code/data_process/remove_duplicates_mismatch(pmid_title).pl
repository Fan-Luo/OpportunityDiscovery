#!/usr/bin/perl -w 

use English;

$result_file = "pmid_title_processed.csv";    #no duplicates, no mismatch (if there are more than one "title" for same pmid, use the most frequent)
open(OUTPUT, ">$result_file") || die "Cannot open file $result_file for writing\n";
print OUTPUT "pmid,title\n";

my %h=();

open(my $fh, '<', 'pmid_title.csv') or die "Can't read file\n";
readline $fh;    # skip the first line 
while (my $line = <$fh>) {
    chomp $line;
	my @pmid_title = split(/,/, $line);
	my $pmid = $pmid_title[0];
    my $title = '';
    for (my $k = 1;$k <= $#pmid_title;$k++)
    { 
        $title = $title.$pmid_title[$k];
    }
    if(exists $h{$pmid} && exists $h{$pmid}{$title}){    #nested hash
    		$h{$pmid}{$title}++;      #counter
    }
    else{
        $h{$pmid}{$title} = 1; 
    }
}
close $fh;

my @pmids = ();
while( my($pmid, $titles) = each %h ){ 
    # my $titles = $h{$pmid};
    my $frequent_title;
    my @key = sort { ${$titles}{$b} <=> ${$titles}{$a}} keys %{$titles};   #%{$titles}: hash reference
    $frequent_title = $key[0];  
    print OUTPUT "$pmid,$frequent_title\n";
}

