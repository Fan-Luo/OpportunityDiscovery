#!/usr/bin/perl -w 

use English;

#use Data::Dump qw(dump);
my @tmp =();
my @hash =();
my @text1 =();
my @text2 =();
my %h=();

open my $edge_node_text, '<', 'edge_node_text.txt' or die $!;
while (my $edge_node_text_line=<$edge_node_text>){
    chomp $edge_node_text_line;
    @tmp = split(/,/, $edge_node_text_line);
    $h{$tmp[0]} = join(",", $tmp[1],$tmp[2]);
}
close $edge_node_text;


my $result = "positive_path_node_text.csv";
open(OUTPUT, ">$result") || die "Cannot open file $result for writing\n";

my $i = 0;
open my $positive, '<', 'positive_path.csv' or die $!;
while (my $positive_line=<$positive>){
    chomp $positive_line; 
    print OUTPUT "$positive_line,";
    if($i == 0){
        $i = 1;
        print OUTPUT "c1.edge_node_text, c3.edge_node_text\n";
    }
    else{
        @tmp =();
        @tmp = split(/,/, $positive_line);
        my $edge_id = trim($tmp[0]); 
        # push @node_hash2,$words[0];
        print OUTPUT "$h{$edge_id}\n";
    }
}

close $positive;

sub trim
{
   my $val = shift;
   $val =~ s/^\s*//;
  # $val =~ s/\s+$//;

   return $val;
} 