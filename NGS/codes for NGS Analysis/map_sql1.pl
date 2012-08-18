#! /usr/bin/perl
# This is a code to insert the bowtie output map files to mysql database.23 tables corresponding to each chromosome is created in MySQL database. Each table corresponponds to a chromosome .
#In each table reads which matches are inserted from all samples


 
use DBI;
use Data::Dumper;

$link = DBI->connect('DBI:mysql:lung_cancer','my_acc','mynewpass') or die "Connection Fail... !!!";

###--------Code to insert map file into sql table------###
	open(F1 , "$ARGV[0]") or die "no";
	
	$count=0;
	if($ARGV[0] =~ m/SRR192333/) {$sampleID="HNS1";}
	elsif($ARGV[0] =~ m/SRR192334/) {$sampleID="HS1";}
	elsif($ARGV[0] =~ m/SRR192335/) {$sampleID="SWOC1";}
	elsif($ARGV[0] =~ m/SRR192336/) {$sampleID="SWC1";}
	elsif($ARGV[0] =~ m/SRR192337/) {$sampleID="HNS2";}
	elsif($ARGV[0] =~ m/SRR192338/) {$sampleID="HS2";}
	elsif($ARGV[0] =~ m/SRR192339/) {$sampleID="SWOC2";}
	elsif($ARGV[0] =~ m/SRR192340/) {$sampleID="SWC2";}
	print "$sampleID";
	
	while($read = <F1>)
	{
		$count++;
		@readLine = split(/\t/,$read);
		$table_name = $readLine[2];
		$enterData = $link->prepare("INSERT INTO $table_name VALUES (?,?,?,?,?,?)");
		
		($readID) = split(/ /,$readLine[0]);
		$read_start     = $readLine[3];
		$read_end       = $readLine[3] + length($readLine[4]) - 1;
		
	$enterData->execute($sampleID, $readID, $readLine[1], $read_start, $read_end, $readLine[4]) or die "Could not execute query!!!";
	}
	print $count,"\n";

###--------Code end--------###
