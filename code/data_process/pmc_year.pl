#! /usr/local/bin/perl

use strict;
# global variable
# my $paper_num = 0;

my $result = "pmc_year.csv";
open(OUTPUT, ">$result") || die "Cannot open file $result for writing\n";
print OUTPUT "pmc,year\n";
# The following subroutine is derived from http://docstore.mik.ua/orelly/perl/cookbook/ch06_10.htm.
# It takes the name of a directory and recursively scans down the filesystem from that point.

#print OUTPUT1 "pmc:ID\n";
#print OUTPUT2 ":START_ID,:END_ID\n";

use Cwd; # module for finding the current working directory

sub ScanDirectory {

   # get the start directory from the passed argument
   my ($workdir) = shift;

   # keep track of where we began
   my ($startdir) = &cwd;

   # change directory to start directory
   chdir($workdir) or die "Unable to enter dir $workdir:$!\n";

   # read directory and store filenames in names arry
   opendir(DIR, ".") or die "Unable to open $workdir:$!\n";
   my @names = readdir(DIR) or die "Unable to read $workdir:$!\n";
   closedir(DIR);


   foreach my $name (@names){
      my $pmc;
      my $year = 0;
      next if ($name eq ".");
      next if ($name eq "..");

      # if directory, recurse
      if (-d $name) {

         &ScanDirectory($name);
         next;
      }

      my $myfile;

      open ($myfile, $name); 
      local $/=undef;
      my $scalar = <$myfile>;
      close ($name);

      # find lines in file matching pattern
      #while (<$myfile>) {

      $pmc = $1 if($scalar =~ m/<article-id pub-id-type="pmc">[^\d]*(\d+)[^\d]*?<\/article-id>/);
      $year = $1 if($scalar =~ m/<year>[^\d]*(\d+)[^\d]*?<\/year>/);

      if($pmc && $year){
         print OUTPUT "$pmc,";
         print OUTPUT "$year\n";
	   }
      elsif($pmc && $year == 0){
         my $path = Cwd::cwd();
         print "$path\n";
         print "$name\n"; 
      }
     
   }

   chdir($startdir) or die "Unable to change to dir $startdir:$!\n";
}

# main program

# initialize start directory to current directory
my $mystartdir = ".";

&ScanDirectory($mystartdir);

# print OUTPUT "Number of files: $file_num";
