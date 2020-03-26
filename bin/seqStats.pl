#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(sum);
use Statistics::Descriptive;
use Getopt::Long;

my ($seqfile, $format);
$format = "fasta";

&GetOptions(
    "f=s" =>\$format,
    "s=s" => \$seqfile
    );

($seqfile)||
    die "by Xiaoli Dong <xdong\@ucalgary.ca> from EBG group at University of Calgary\n".
    "Usage $0 OPTIONS\n".
    " -f <input file format, fasta|fastq, default: fasta>\n".
    " -s <fasta or fastq sequence file, it can be compressed gz file>\n";
    
my %statInfo = ();

$Statistics::Descriptive::Tolerance = 1e-24;
my $stat = Statistics::Descriptive::Full->new();
my $flens = [];
if($format eq "fasta"){
    $flens = readFasta("$seqfile");
}
elsif($format eq "fastq"){
    $flens = readFastq("$seqfile");
}
my $c = scalar @$flens;
my @simple_stats = ();
if(@$flens){
    $stat->add_data(@$flens);
    push(@simple_stats, $stat->min());
    push(@simple_stats, $stat->max());
    push(@simple_stats, sprintf("%0.2f", $stat->mean()));
    push(@simple_stats,  sprintf("%0.2f", $stat->median()));
    #push(@simple_stats, $stat->mode());
    push(@simple_stats, $stat->count());
    push(@simple_stats, $stat->sum());
    push(@simple_stats, sprintf("%0.2f", $stat->standard_deviation()));
    push(@simple_stats, get_N50($flens));
}


my @header = ("min", "max", "mean", "median", "count", "total_bp", "std", "N50");
print join(",", @header), "\n";
print join(",", @simple_stats),"\n";


sub readFasta{
    my($fastaFile) = @_;
    my @lens = ();
    if ($fastaFile =~ /.gz$/) {
	open(FASTA, "gunzip -c $fastaFile |") or die "Could not open $fastaFile file to read, $!\n";
	$/ = "\n>";
	while (<FASTA>){
	    chomp;
	    if(! />?(\S+).*?\n(.+)/s){
		die "Could not read fasta record #$.: $_\n";
	    }
	    my $id = $1;
	    my $sequence = $2;
	    $sequence =~ s/\s+//g;
	    my $len = length ($sequence);
	    push(@lens, $len);
	}
	$/ = "\n";
	close(FASTA);
    }
    else{
	open(FASTA, $fastaFile) or die "Could not open $fastaFile file to read, $!\n";
	$/ = "\n>";
	while (<FASTA>){
	    chomp;
	    if(! />?(\S+).*?\n(.+)/s){
		die "Could not read fasta record #$.: $_\n";
	    }
	    my $id = $1;
	    my $sequence = $2;
	    $sequence =~ s/\s+//g;
	    my $len = length ($sequence);
	    push(@lens, $len);
	}
	$/ = "\n";
	close(FASTA);
    }
    return \@lens;

}
sub readFastq{
    my($fastqFile) = @_;
    my @lens = ();


    if ($fastqFile =~ /.gz$/) {

	open(FASTQ, "gunzip -c $fastqFile |") or die "Could not open $fastqFile file to read, $!\n";

	while (<FASTQ>){
	    chomp;
	    my $sequence = <FASTQ>;
	    <FASTQ>;
	    <FASTQ>;
	    $sequence =~ s/\s+//g;
	    my $len = length ($sequence);
	    push(@lens, $len);
	}
	close(FASTQ);

    }
    else {
	open(FASTQ, $fastqFile) or die "Could not open $fastqFile file to read, $!\n";

	while (<FASTQ>){
	    chomp;
	    my $sequence = <FASTQ>;
	    <FASTQ>;
	    <FASTQ>;
	    $sequence =~ s/\s+//g;
	    my $len = length ($sequence);
	    push(@lens, $len);
	}
	close(FASTQ);
    }


    return \@lens;
}
sub get_N50{
    my ($arrRef) = @_;
    my @sort = sort {$b <=> $a} @$arrRef;
    my $totalLength = sum(@sort);
    my $n50 = 0;
    my $n50_value = 0;
    foreach my $val(@sort){
	$n50+=$val;
	if($n50 >= $totalLength/2){
	    #print "N50 length is $n50 and N50 value is: $val\n";
	    $n50_value = $val;
	    last;
	}
    }
    return $n50_value;
}

