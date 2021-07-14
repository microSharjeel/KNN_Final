`timescale 1ns/1ps
`include "iob_lib.vh"
`include "KNN_Header.vh"
module	knn_fsm
  #(
	parameter SIZE =     3,
	parameter IDLE  =    3'b001,
	parameter COMPUTE =  3'b010,
   	parameter OUTPUT  =  3'b100
    )
	(
	//to and from datapath
	 output reg [`WDATA_W-1:0] KNN_TEST_PT_O,
	 output reg [`WDATA_W-1:0] KNN_DATA_PT_O,
	 output reg KNN_START_O,
	
	//to and from KNN top level and KNN core 
	`INPUT(KNN_START_FSM,      1),
	`INPUT(KNN_DATA_PT_FSM0,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM1,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM2,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM3,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM4,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM5,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM6,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM7,    `WDATA_W),
	
	`INPUT(KNN_DATA_PT_FSM8,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM9,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM10,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM11,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM12,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM13,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM14,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM15,    `WDATA_W),
	
	
	`INPUT(KNN_DATA_PT_FSM16,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM17,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM18,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM19,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM20,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM21,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM22,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM23,    `WDATA_W),
	
		
	`INPUT(KNN_DATA_PT_FSM24,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM25,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM26,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM27,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM28,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM29,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM30,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM31,    `WDATA_W),
	
	
	
	`INPUT(KNN_DATA_PT_FSM32,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM33,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM34,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM35,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM36,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM37,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM38,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM39,    `WDATA_W),
	
	`INPUT(KNN_DATA_PT_FSM40,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM41,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM42,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM43,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM44,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM45,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM46,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM47,    `WDATA_W),
	
	`INPUT(KNN_DATA_PT_FSM48,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM49,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM50,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM51,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM52,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM53,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM54,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM55,    `WDATA_W),
	
	`INPUT(KNN_DATA_PT_FSM56,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM57,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM58,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM59,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM60,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM61,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM62,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM63,    `WDATA_W),
	
	`INPUT(KNN_DATA_PT_FSM64,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM65,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM66,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM67,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM68,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM69,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM70,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM71,    `WDATA_W),
	
	`INPUT(KNN_DATA_PT_FSM72,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM73,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM74,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM75,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM76,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM77,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM78,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM79,    `WDATA_W),
	
	`INPUT(KNN_DATA_PT_FSM80,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM81,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM82,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM83,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM84,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM85,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM86,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM87,    `WDATA_W),
	
	`INPUT(KNN_DATA_PT_FSM88,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM89,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM90,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM91,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM92,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM93,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM94,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM95,    `WDATA_W),
	
	`INPUT(KNN_DATA_PT_FSM96,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM97,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM98,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM99,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM100,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM101,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM102,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM103,    `WDATA_W),
	
	
	`INPUT(KNN_DATA_PT_FSM104,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM105,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM106,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM107,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM108,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM109,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM110,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM111,    `WDATA_W),
	
	
	`INPUT(KNN_DATA_PT_FSM112,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM113,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM114,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM115,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM116,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM117,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM118,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM119,    `WDATA_W),
	
	
	`INPUT(KNN_DATA_PT_FSM120,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM121,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM122,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM123,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM124,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM125,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM126,    `WDATA_W),
	`INPUT(KNN_DATA_PT_FSM127,    `WDATA_W),
	`INPUT(KNN_TEST_PT_FSM,    `WDATA_W),
	`INPUT(KNN_VALID_IN_FSM,   `KNN_VALID_W),
	 output reg KNN_VALID_O,
	`INPUT(clk,                1),
	`INPUT(rst,                1)
	);

reg [(`KNN_LOW_W+`KNN_HIGH_W)-1:0]data_points[`K_NUM_DATA_PTS-1:0];

`SIGNAL(state, SIZE)
`SIGNAL(count_wr, `K_NUM_DATA_PTS_BIT+1)
//`SIGNAL(addr, `K_NUM_DATA_PTS_BIT)
//`SIGNAL(cnt, 3)
integer i;

always @(posedge clk or posedge rst)
begin
	if(rst)	
	begin
		for (i = 0; i <= (`K_NUM_DATA_PTS-1); i = i + 1) begin data_points[i] <= 0; end
		
	end	
	else if(KNN_VALID_IN_FSM)
	begin

	 	   data_points[0]<=KNN_DATA_PT_FSM0;  
	 	   data_points[1]<=KNN_DATA_PT_FSM1;
	 	   data_points[2]<=KNN_DATA_PT_FSM2;
	 	   data_points[3]<=KNN_DATA_PT_FSM3;
	 	   data_points[4]<=KNN_DATA_PT_FSM4;
	 	   data_points[5]<=KNN_DATA_PT_FSM5;
	 	   data_points[6]<=KNN_DATA_PT_FSM6;
	 	   data_points[7]<=KNN_DATA_PT_FSM7;
		   
		   
		   data_points[8]<=KNN_DATA_PT_FSM8;
	 	   data_points[9]<=KNN_DATA_PT_FSM9;
	 	   data_points[10]<=KNN_DATA_PT_FSM10;
	 	   data_points[11]<=KNN_DATA_PT_FSM11;
	 	   data_points[12]<=KNN_DATA_PT_FSM12;
	 	   data_points[13]<=KNN_DATA_PT_FSM13;
	 	   data_points[14]<=KNN_DATA_PT_FSM14;
	 	   data_points[15]<=KNN_DATA_PT_FSM15;
		   
		   
		   data_points[16]<=KNN_DATA_PT_FSM16;
	 	   data_points[17]<=KNN_DATA_PT_FSM17;
	 	   data_points[18]<=KNN_DATA_PT_FSM18;
	 	   data_points[19]<=KNN_DATA_PT_FSM19;
	 	   data_points[20]<=KNN_DATA_PT_FSM20;
	 	   data_points[21]<=KNN_DATA_PT_FSM21;
	 	   data_points[22]<=KNN_DATA_PT_FSM22;
	 	   data_points[23]<=KNN_DATA_PT_FSM23;
		   
		   
		   data_points[24]<=KNN_DATA_PT_FSM24;
	 	   data_points[25]<=KNN_DATA_PT_FSM25;
	 	   data_points[26]<=KNN_DATA_PT_FSM26;
	 	   data_points[27]<=KNN_DATA_PT_FSM27;
	 	   data_points[28]<=KNN_DATA_PT_FSM28;
	 	   data_points[29]<=KNN_DATA_PT_FSM29;
	 	   data_points[30]<=KNN_DATA_PT_FSM30;
	 	   data_points[31]<=KNN_DATA_PT_FSM31;
		   
		   
		   data_points[32]<=KNN_DATA_PT_FSM32;
	 	   data_points[33]<=KNN_DATA_PT_FSM33;
	 	   data_points[34]<=KNN_DATA_PT_FSM34;
	 	   data_points[35]<=KNN_DATA_PT_FSM35;
	 	   data_points[36]<=KNN_DATA_PT_FSM36;
	 	   data_points[37]<=KNN_DATA_PT_FSM37;
	 	   data_points[38]<=KNN_DATA_PT_FSM38;
	 	   data_points[39]<=KNN_DATA_PT_FSM39;
		   
		   data_points[40]<=KNN_DATA_PT_FSM40;
	 	   data_points[41]<=KNN_DATA_PT_FSM41;
	 	   data_points[42]<=KNN_DATA_PT_FSM42;
	 	   data_points[43]<=KNN_DATA_PT_FSM43;
	 	   data_points[44]<=KNN_DATA_PT_FSM44;
	 	   data_points[45]<=KNN_DATA_PT_FSM45;
	 	   data_points[46]<=KNN_DATA_PT_FSM46;
	 	   data_points[47]<=KNN_DATA_PT_FSM47;
		   
		   
		   data_points[48]<=KNN_DATA_PT_FSM48;
	 	   data_points[49]<=KNN_DATA_PT_FSM49;
	 	   data_points[50]<=KNN_DATA_PT_FSM50;
	 	   data_points[51]<=KNN_DATA_PT_FSM51;
	 	   data_points[52]<=KNN_DATA_PT_FSM52;
	 	   data_points[53]<=KNN_DATA_PT_FSM53;
	 	   data_points[54]<=KNN_DATA_PT_FSM54;
	 	   data_points[55]<=KNN_DATA_PT_FSM55;
		   
		   data_points[56]<=KNN_DATA_PT_FSM56;
	 	   data_points[57]<=KNN_DATA_PT_FSM57;
	 	   data_points[58]<=KNN_DATA_PT_FSM58;
	 	   data_points[59]<=KNN_DATA_PT_FSM59;
	 	   data_points[60]<=KNN_DATA_PT_FSM60;
	 	   data_points[61]<=KNN_DATA_PT_FSM61;
	 	   data_points[62]<=KNN_DATA_PT_FSM62;
	 	   data_points[63]<=KNN_DATA_PT_FSM63;
		   
		   
		   data_points[64]<=KNN_DATA_PT_FSM64;
	 	   data_points[65]<=KNN_DATA_PT_FSM65;
	 	   data_points[66]<=KNN_DATA_PT_FSM66;
	 	   data_points[67]<=KNN_DATA_PT_FSM67;
	 	   data_points[68]<=KNN_DATA_PT_FSM68;
	 	   data_points[69]<=KNN_DATA_PT_FSM69;
	 	   data_points[70]<=KNN_DATA_PT_FSM70;
	 	   data_points[71]<=KNN_DATA_PT_FSM71;
		   
		   
		   data_points[72]<=KNN_DATA_PT_FSM72;
	 	   data_points[73]<=KNN_DATA_PT_FSM73;
	 	   data_points[74]<=KNN_DATA_PT_FSM74;
	 	   data_points[75]<=KNN_DATA_PT_FSM75;
	 	   data_points[76]<=KNN_DATA_PT_FSM76;
	 	   data_points[77]<=KNN_DATA_PT_FSM77;
	 	   data_points[78]<=KNN_DATA_PT_FSM78;
	 	   data_points[79]<=KNN_DATA_PT_FSM79;
		   
		   		   
		   data_points[80]<=KNN_DATA_PT_FSM80;
	 	   data_points[81]<=KNN_DATA_PT_FSM81;
	 	   data_points[82]<=KNN_DATA_PT_FSM82;
	 	   data_points[83]<=KNN_DATA_PT_FSM83;
	 	   data_points[84]<=KNN_DATA_PT_FSM84;
	 	   data_points[85]<=KNN_DATA_PT_FSM85;
	 	   data_points[86]<=KNN_DATA_PT_FSM86;
	 	   data_points[87]<=KNN_DATA_PT_FSM87;
		   
		   
		   data_points[88]<=KNN_DATA_PT_FSM88;
	 	   data_points[89]<=KNN_DATA_PT_FSM89;
	 	   data_points[90]<=KNN_DATA_PT_FSM90;
	 	   data_points[91]<=KNN_DATA_PT_FSM91;
	 	   data_points[92]<=KNN_DATA_PT_FSM92;
	 	   data_points[93]<=KNN_DATA_PT_FSM93;
	 	   data_points[94]<=KNN_DATA_PT_FSM94;
	 	   data_points[95]<=KNN_DATA_PT_FSM95;
		   	   
		   
		   
		   data_points[96]<=KNN_DATA_PT_FSM96;
	 	   data_points[97]<=KNN_DATA_PT_FSM97;
	 	   data_points[98]<=KNN_DATA_PT_FSM98;
	 	   data_points[99]<=KNN_DATA_PT_FSM99;
	 	   data_points[100]<=KNN_DATA_PT_FSM100;
	 	   data_points[101]<=KNN_DATA_PT_FSM101;
	 	   data_points[102]<=KNN_DATA_PT_FSM102;
	 	   data_points[103]<=KNN_DATA_PT_FSM103;
		   
		   
		   data_points[104]<=KNN_DATA_PT_FSM104;
	 	   data_points[105]<=KNN_DATA_PT_FSM105;
	 	   data_points[106]<=KNN_DATA_PT_FSM106;
	 	   data_points[107]<=KNN_DATA_PT_FSM107;
	 	   data_points[108]<=KNN_DATA_PT_FSM108;
	 	   data_points[109]<=KNN_DATA_PT_FSM109;
	 	   data_points[110]<=KNN_DATA_PT_FSM110;
	 	   data_points[111]<=KNN_DATA_PT_FSM111;
		   
		   		   
		   data_points[112]<=KNN_DATA_PT_FSM112;
	 	   data_points[113]<=KNN_DATA_PT_FSM113;
	 	   data_points[114]<=KNN_DATA_PT_FSM114;
	 	   data_points[115]<=KNN_DATA_PT_FSM115;
	 	   data_points[116]<=KNN_DATA_PT_FSM116;
	 	   data_points[117]<=KNN_DATA_PT_FSM117;
	 	   data_points[118]<=KNN_DATA_PT_FSM118;
	 	   data_points[119]<=KNN_DATA_PT_FSM119;
		   
		   
		   data_points[120]<=KNN_DATA_PT_FSM120;
	 	   data_points[121]<=KNN_DATA_PT_FSM121;
	 	   data_points[122]<=KNN_DATA_PT_FSM122;
	 	   data_points[123]<=KNN_DATA_PT_FSM123;
	 	   data_points[124]<=KNN_DATA_PT_FSM124;
	 	   data_points[125]<=KNN_DATA_PT_FSM125;
	 	   data_points[126]<=KNN_DATA_PT_FSM126;
	 	   data_points[127]<=KNN_DATA_PT_FSM127;
		   
		   
	end
    
end

 always @(posedge clk or posedge rst)

 begin : FSM_SEQ
    
	if(rst)
	begin
		state<= IDLE;
	end
	else
	begin
	  case(state)
	     IDLE:	
			if((KNN_START_FSM==1)) 
			begin	
				state <= COMPUTE;
			end	
	    		else if((KNN_START_FSM==0))
	    		begin
				state <=  IDLE;
     			end
         	    
		 COMPUTE:
			 if( (count_wr <= `K_NUM_DATA_PTS+2)  &&(KNN_START_FSM==1) ) //(count_wr <= `K_NUM_DATA_PTS+1)
			begin
				state <= COMPUTE;
			end
		  else if ( (count_wr > `K_NUM_DATA_PTS+2) &&(KNN_START_FSM==1)  )//(count_wr > `K_NUM_DATA_PTS+1)
			begin
	
				state <= OUTPUT;
			end
		 OUTPUT:
		 	if( (KNN_START_FSM==1))
			begin
				state <= OUTPUT;
			end
			else if( (KNN_START_FSM==0))
			begin
				state<= IDLE;
			end 
	      default : 
			state <= IDLE;

		endcase
	end
  
 end 

always @(posedge clk or posedge rst)
 begin
	if(rst)
	begin
		count_wr<=0;
		KNN_START_O   <= 1'b0;
		KNN_TEST_PT_O <= 32'd0;
		KNN_DATA_PT_O <= 32'd0;
		
		
	end
	else 
	begin
		if(state==COMPUTE &&  count_wr <= (`K_NUM_DATA_PTS+2)) // (`K_NUM_DATA_PTS+1)
		 begin	
			if(count_wr<=(`K_NUM_DATA_PTS-1))
			begin
				KNN_TEST_PT_O <= KNN_TEST_PT_FSM;
				KNN_DATA_PT_O <= data_points[count_wr];
				KNN_START_O   <= 1'b1;
				
			end
			 else if(count_wr>(`K_NUM_DATA_PTS-1) && (count_wr<=`K_NUM_DATA_PTS+1)) //(count_wr>(`K_NUM_DATA_PTS-1))
			begin
				KNN_TEST_PT_O <= 32'd0;
				KNN_DATA_PT_O <= 32'd0;
				KNN_START_O   <= 1'b1;
				
			end	
			count_wr <= count_wr +1;
			
		 end
		 else 
		 begin
			KNN_TEST_PT_O <= 32'd0;
			KNN_DATA_PT_O <= 32'd0;
			KNN_START_O   <= 1'b0;
			count_wr<= 0;
			
			
		 end
	end
end	

always @(posedge clk or posedge rst)
 begin
	if(rst)
	begin
		KNN_VALID_O   <= 1'b0;
	end
	else 
	begin
		 if( (state==OUTPUT))
		 begin	
			KNN_VALID_O   <= 1'b1;
		 end

		 else
		 	KNN_VALID_O   <= 1'b0;
		 
	end
end
endmodule 


	
