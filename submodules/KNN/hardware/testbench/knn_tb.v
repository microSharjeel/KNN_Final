`timescale 1ns/1ps
`include "iob_lib.vh"
module knn_tb;

   localparam PER=10;
   
   `CLOCK(clk_tb, PER)

   reg rst_tb;
  `SIGNAL(KNN_START_IN_TB,1)
  `SIGNAL(KNN_DATA_PT_IN_TB,32)
  `SIGNAL(KNN_TEST_PT_IN_TB,32)
  `SIGNAL(KNN_VALID_IN_TB,1)
  `SIGNAL(KNN_SAMPLE_ADD_TB,1)
  `SIGNAL_OUT(KNN_VALID_OUT_TB,1)
  `SIGNAL(DATA_X,16)
  `SIGNAL(DATA_Y,16)
  
  `SIGNAL_OUT(KN1_OUT_CORE_TB,32)
  `SIGNAL_OUT(KN2_OUT_CORE_TB,32)
  `SIGNAL_OUT(KN3_OUT_CORE_TB,32)
  `SIGNAL_OUT(KN4_OUT_CORE_TB,32)
  `SIGNAL_OUT(KN5_OUT_CORE_TB,32)
  `SIGNAL_OUT(KN6_OUT_CORE_TB,32)
  
  `SIGNAL_OUT(IN1_OUT_CORE_TB,7)
  `SIGNAL_OUT(IN2_OUT_CORE_TB,7)
  `SIGNAL_OUT(IN3_OUT_CORE_TB,7)
  `SIGNAL_OUT(IN4_OUT_CORE_TB,7)
  `SIGNAL_OUT(IN5_OUT_CORE_TB,7)
  `SIGNAL_OUT(IN6_OUT_CORE_TB,7)
  
  
//instantiate knn core
knn_core knn_core_tb
(
  .KNN_START_CORE(KNN_START_IN_TB),
  .KNN_DATA_PT_CORE(KNN_DATA_PT_IN_TB),
  .KNN_TEST_PT_CORE(KNN_TEST_PT_IN_TB),
  .KNN_VALID_CORE(KNN_VALID_IN_TB),
  .KNN_SAMPLE_CORE(KNN_SAMPLE_ADD_TB),
  .KNN_VALID_OUT_CORE(KNN_VALID_OUT_TB),
 
  .KN1_OUT_CORE(KN1_OUT_CORE_TB),
  .KN2_OUT_CORE(KN2_OUT_CORE_TB),
  .KN3_OUT_CORE(KN3_OUT_CORE_TB),
  .KN4_OUT_CORE(KN4_OUT_CORE_TB),
  .KN5_OUT_CORE(KN5_OUT_CORE_TB),
  .KN6_OUT_CORE(KN6_OUT_CORE_TB),

  .IN1_OUT_CORE(IN1_OUT_CORE_TB),
  .IN2_OUT_CORE(IN2_OUT_CORE_TB),
  .IN3_OUT_CORE(IN3_OUT_CORE_TB),
  .IN4_OUT_CORE(IN4_OUT_CORE_TB),
  .IN5_OUT_CORE(IN5_OUT_CORE_TB),
  .IN6_OUT_CORE(IN6_OUT_CORE_TB),

  .CLK_CORE(clk_tb),
  .RST_CORE(rst_tb)

);
  /*knn_core knn_core_tb
	(
	  .KNN_START_IN(KNN_START_IN_TB),
	  .KNN_DATA_PT_IN(KNN_DATA_PT_IN_TB),
	  .KNN_TEST_PT_IN(KNN_TEST_PT_IN_TB),
	  .KNN_VALID_IN(KNN_VALID_IN_TB),
	  .KNN_SAMPLE_ADD(KNN_SAMPLE_ADD_TB),
	  .KNN_ADDRESS_TOP(KNN_ADDRESS_TOP_TB),
	  .KNN_ADD(KNN_ADD_TB),
	  .KNN_VALID_OUT(KNN_VALID_OUT_TB),
	  
	  .clk_top(clk_tb),
	  .rst_top(rst_tb)

	);
 */
  initial
  begin
   $dumpfile("knn.vcd");
   $dumpvars(3,knn_tb);
   #1 KNN_START_IN_TB    <=1'b0;
   #1 KNN_DATA_PT_IN_TB  <=32'd0;
   #1 KNN_TEST_PT_IN_TB  <=32'd0;
   #1 KNN_VALID_IN_TB    <=1'b0;
   #1 DATA_X <=16'd 10;
   #1 DATA_Y <=16'd 11;
   #1 KNN_SAMPLE_ADD_TB<=1'b1;
  	//reset
  @(posedge clk_tb)
  #5 rst_tb = 1; 
  @(posedge clk_tb)  
  #5 rst_tb = 0;

forever
begin
	//valid_in data test
	 repeat(129) @(posedge clk_tb)
	  begin
	   
	    KNN_START_IN_TB    <=1'b0;
	    KNN_DATA_PT_IN_TB  <= {DATA_X,DATA_Y};
	    KNN_TEST_PT_IN_TB  <={16'd30,16'd10};
	    KNN_VALID_IN_TB    <=1'b1;
	    DATA_X <= $random %10;//DATA_X -1;
	    DATA_Y <=  $random %20;//DATA_Y +1; 
	   // KNN_SAMPLE_ADD_TB<=1'b0;
	  end
	//start fsm
	repeat(200) @(posedge clk_tb) 	
	  //@(posedge clk_tb)
		begin
	   #1 KNN_START_IN_TB    <=1'b1;
	   #1 KNN_VALID_IN_TB    <=1'b0;
		end
	@(posedge clk_tb)
	begin
	  #1 KNN_START_IN_TB    <=1'b0;
	end  
	repeat(200) @(posedge clk_tb);
 end	
	$stop;
end	
/*always@(posedge clk_tb)
begin
	if(KNN_VALID_OUT_TB)
		KNN_SAMPLE_ADD_TB<=1'b1;
end
*/
endmodule
