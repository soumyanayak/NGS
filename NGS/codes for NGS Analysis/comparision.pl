open(handle1,"input_comparision_HS1.txt");
$i=0;

@file1= <handle1>;
close(handle1);
foreach $eachline (@file1){
	
	chomp($eachline);
	#print $eachline ;
	@varfile1=split(' ',$eachline);
	#print "the $varfile1[1]";	
	$file1_col1[$i]=$varfile1[0];
	#print "one element of var file is $varfile1[0]";
	$i++;
}




open(handle3,"input_comparision_swc1.txt");
@file3= <handle3>;
close(handle3);
#print "These are the contents of file 2: @file2 \n";
$j=0;
foreach $eachline (@file3){
	
	chomp($eachline);
	@varfile3=split(' ',$eachline);
	#print "This is one row of file 2 $varfile2[1] \n";
	$array_hash1[$j]=$varfile3[0];
	#print "This is one row of file 2 hash $array_hash[$j] \n";
	$j++;
	$array_hash1[$j]=$varfile3[1];
	$j++;
}
#print "These are the contents of file2:\n @array_hash \n";
%hash1=@array_hash1;


open(handle4,"input_comparision_HS1.txt");
@newfile1= <handle4>;

close(handle4); 
#print @newfile1;

#open(handle5,"book6.txt");
#@newfile2= <handle5>;

#close(handle6); 

open(handle_new,">output.txt");

$counter=0;








foreach $line (@file1_col1)
{
	foreach $line_arr (@array_hash1)
	{
		if($line_arr eq $line)
		{
		#print $line_arr;
		$var=$line;
		print "$var \n";
		chomp($newfile1[$counter]);
			@new_vec=split("\t",$newfile1[$counter]);
			#print $new_vec[1];
			push(@new_vec,$hash1{$var});
			$output_vec=join("\t",@new_vec);
			print $output_vec;

			print handle_new "$output_vec\n";;
			print "\n $output_vec\n";
		
		}
	}
$counter++;
}
close(handle_new);

















































