//About: This design counts the occurence of a 4-bit data in a 8-bit long data
module mk_SEARCH (

   CLK,              // clock
   RST_N,            // active-low reset
   str,              // string you are looking for
   data,             // raw data to be searched
   num_matches,	  // Result. Number of times str was found in data
   search_control	  //Search control
);

  input  CLK;
  input  RST_N;

  input  [3 : 0] str;
  input  [7: 0] data;
  input  [1 : 0] search_control;
  output reg [7 : 0] num_matches;
  
  reg [3:0] med;
  integer i=0;

  always@(posedge CLK or negedge RST_N)
	begin
	 if(RST_N==1'b0)						//Active low reset
		begin
		 num_matches[7:0]=8'b0;
		 i=0;
		end
	else if(RST_N==1'b1 && search_control==2'b01)
       begin
		while(((i<8) &&  (CLK)))							//Comparison algorithm
		begin
		 med={data[i+3],data[i+2],data[i+1],data[i]};
		if((med==str))
		begin
		 $display("i=%d,med=%b,str=%b,cmp=%b",i,med,str,num_matches);
		 num_matches[7:0]=num_matches[7:0]+8'b1;
		end
		i=i+1;
	      end
	  end
	end


endmodule  // mk_SEARCH

