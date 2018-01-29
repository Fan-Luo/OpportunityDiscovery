#!/usr/bin/perl -w 

use English;
 
$result_file = 'sorted_by_noisy_or.tsv';
open(OUTPUT, ">$result_file") || die "Cannot open file $result_file for writing\n";
print OUTPUT "predict finding\tgold lable\tnoisy_or\tgold polarity\tevidence(s)\n";

my %h1=();   # edge_id
my %h2=();   # noisy_or
my %h3=();   # gold label
my %h4=();   # edge lable (increase or decrease)

open(my $fh, '<', 'classifiers_probabilities.tsv') or die "Can't read file\n";
readline $fh;    # skip the first line 
while (my $line = <$fh>) {
    chomp $line;
	my @tmp = split(/\t/, $line);
	my $new_finding = $tmp[9];
    my $y_true = $tmp[3];               # A->C exists, its edge_label is either increase or decrease
    my $y_pred = $tmp[2];               # A->C is predicted
    my $edge_id;
    my $edge_label;
    if($y_true){      
        $edge_id = $tmp[10];
        $edge_label = $tmp[11];
    }
    
    if($y_pred){
        my $pro0 = $tmp[0];
        if(exists $h2{$new_finding}){    
        	$h2{$new_finding} *= $pro0;     
            if($y_true and !(grep( /^$edge_id$/, @{$h1{$new_finding}}))){    # $edge_id is not in $h1{$new_finding}
                push $h1{$new_finding}, $edge_id;      # there might be contradiction, so more than one edge_id
                push $h4{$new_finding}, $edge_label;
            } 
        }
        else{
            if($y_true){
                $h1{$new_finding} = [];
                push $h1{$new_finding}, $edge_id;
                $h4{$new_finding} = [];
                push $h4{$new_finding}, $edge_label;
            }
            $h2{$new_finding} = $pro0;
            $h3{$new_finding} = $y_true;  
        }
    } 
}
 
close $fh;

while( my($new_finding, $pro0_product) = each %h2 ){   #calculate noisy-or
    $noisy_or = 1 - $pro0_product;
    $h2{$new_finding} = $noisy_or; 
}


# fetch evidence with EDGE_DEDUPLICATION_HASH (edge_id)
my @edge_ids = ();
my @edge_text = ();
open my $evidence_file, '<', 'all_evidence_with_id.tsv' or die $!;
while (my $line=<$evidence_file>){
    chomp $line;
    my @tmp = split(/\t/, $line);
    push @edge_ids,$tmp[1];
    push @edge_text,$tmp[7];
}
close $evidence_file;

my %evidence_hash=();
for (my $k = 0;$k <= $#edge_ids;$k++){
    if(!(exists $evidence_hash{$edge_ids[$k]})){    
        $evidence_hash{$edge_ids[$k]} = [];
    }
    push $evidence_hash{$edge_ids[$k]}, $edge_text[$k];
}


my @key = sort { $h2{$b} <=> $h2{$a}} keys %h2;         # sort by noisy-or and then print 
for (my $k = 0;$k <= $#key;$k++)
{   
    $new_finding = $key[$k];
    print OUTPUT "$new_finding\t";
    print OUTPUT "$h3{$new_finding}\t";
    print OUTPUT "$h2{$new_finding}";
    if($h3{$new_finding}){
        my $eids = $h1{$new_finding};                   #其中$eids是数组的地址 
        for (my $d = 0;$d <= $#$eids;$d++){
            my $labels = $h4{$new_finding};
            print OUTPUT "\t@$labels[$d]\t";
            my $eid = @$eids[$d];
            my $evidences = $evidence_hash{$eid};
            for (my $e = 0;$e <= $#$evidences;$e++){    #同一个EDGE_DEDUPLICATION_HASH可能有多个evidence
                print OUTPUT "\"@$evidences[$e]\";";
            }

        }
        
    }
    print OUTPUT "\n";
} 

