#! /usr/bin/perl
# This is a code to calculate the reads per genes for all the genes for all the samples.

 
use DBI;
use Data::Dumper;
system("date");
$link = DBI->connect('DBI:mysql:lung_cancer','my_acc','mynewpass') or die "Connection Fail... !!!";
@samples = ("HNS1","HS1","SWOC1","SWC1","HNS2","HS2","SWOC2","SWC2");

###---------Calculate reads per gene for all the genes for each sample----------###

$sample1 = join('_',@samples);
$out_file = "reads_per_gene_".$sample1;
open(F1, ">$out_file");
print F1 "Acc_ID\tChr";
map {print F1 "\t$_"} (@samples);
print F1 "\tGene_Name\n";

open(F2, "/home/workshop/project/gene_expression/mohit/old_codes/hg19_geneloci.tab");

#accession	version	    gene	geneSymbol	protein	   chromosome	start	end	     type
#uc001aaa.3	uc001aaa.3  null	null	         BZX12      1     	14409	15669        knownGene
$geneLine = <F2>;
while($geneLine = <F2>)
{
	($accesion, $version, $geneName, $geneSymbol, $protein, $chr, $geneStart, $geneEnd) = split(/\t/,$geneLine);
	next	if($chr=~/_/);
	$chr = "chr".$chr;
	$reads_per_gene = $link->prepare("select count(*) from $chr where sample = ? and start >= ? and start <= ?") or die "Couldn't prepare query!!";
	@a=();
	foreach $sample (@samples)
	{
		$reads_per_gene->execute($sample,$geneStart, $geneEnd) or die "Couldn't execute query!!";
		@count_rpg = $reads_per_gene->fetchrow_array();
#		$count_rpg[0] = 0 if(!@count_rpg);
		@a = (@a,@count_rpg);
		@count_rpg=();
	}
#	print "@a\n";
	print F1 "$accesion\t$chr";
	map {print F1 "\t$_" }(@a);
	print F1 "\t$geneName\n";
}
close F2;
close F1;
