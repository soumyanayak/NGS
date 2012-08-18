   
#______________Reads matched_____________
#@numbers = (35737033,20550428,29456188,27880571,13780962,12847825,11975631,2237544);
#use POSIX qw(log10);
@numbers = (56402940,34467938,44489009,29456188,27880571,13780962,12847825,11975631);

#print "@numbers";
open(handle1,"rpkm_in.txt")or die "cannot open the file";
open(handle_out,">outputfile_new2.txt")or die "cannot open the file";

@file1= <handle1>;
close(handle1);

#print "@file1";

foreach $eachline (@file1)
{
	chomp($eachline);
	#print "$eachline \n";
	@row=split("\t",$eachline);
	#print " this is an element of array $row[2] \n";
	
	for($i=2;$i<=9;$i++)
	{	
		$x=$i-2;
		#print $x;
		$first_val=$numbers[$x];
		$first_val1=$first_val/1000000.0;
		print "$first_val1 is :) \n";
		#print "$row[$i] \n";
		$second_val=$row[11];
		#print "$second_val";
		$second_val1=$second_val/1000.0;
		#print "$second_val1 \n";

		#_____________Compute RPKM______________

		if ($row[$i]!= 0)
		{
			#$rpkm=0;
			$row[$i]=($row[$i])/($first_val1*$second_val1);
			
			
		}
		$row[12]=(log($row[2]/$row[6]))/(log (2));
		$row[13]=(log($row[3]/$row[7]))/(log (2));
			$row[14]=(log($row[4]/$row[8]))/(log (2));
			$row[15]=(log($row[5]/$row[9]))/(log (2));
			$row[16]=(log($row[2]/$row[3]))/(log (2));
			$row[17]=(log($row[2]/$row[5]))/(log (2));
			$row[18]=(log($row[3]/$row[5]))/(log (2));
			$row[19]=(log($row[6]/$row[7]))/(log (2));
			$row[20]=(log($row[6]/$row[9]))/(log (2));
			$row[21]=(log($row[7]/$row[9]))/(log (2));
		
		

		
		print "this is the rpkm value $row[$i]\t";
	}
	#_________________Writing to the output file___________
	$output_vec=join("\t",@row);
	print handle_out "$output_vec\n";
	print "\n $output_vec\n";


	

}









