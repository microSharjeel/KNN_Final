`timescale 1ns/1ps
`include "iob_lib.vh"
`include "KNN_Header.vh"

module	knn_datapath
(
	//from fsm
	`INPUT(KNN_TEST_PT_DP,`WDATA_W),
	`INPUT(KNN_DATA_PT_DP,`WDATA_W),
	`INPUT(KNN_START_DP,1),
	
	//from sw reg
	`INPUT(KNN_SAMPLE_DP,1),
	//to sw reg
	`OUTPUT(KN1_OUT,`WDATA_W),
	`OUTPUT(KN2_OUT,`WDATA_W),
	`OUTPUT(KN3_OUT,`WDATA_W),
	`OUTPUT(KN4_OUT,`WDATA_W),
	`OUTPUT(KN5_OUT,`WDATA_W),
	`OUTPUT(KN6_OUT,`WDATA_W),
	
	`OUTPUT(IN1_OUT,`K_NUM_DATA_PTS_BIT),
	`OUTPUT(IN2_OUT,`K_NUM_DATA_PTS_BIT),
	`OUTPUT(IN3_OUT,`K_NUM_DATA_PTS_BIT),
	`OUTPUT(IN4_OUT,`K_NUM_DATA_PTS_BIT),
	`OUTPUT(IN5_OUT,`K_NUM_DATA_PTS_BIT),
	`OUTPUT(IN6_OUT,`K_NUM_DATA_PTS_BIT),
	
	`INPUT(clk, 1),
        `INPUT(rst, 1)
);
	//defining signals for datapath
	wire signed [15:0]two_comp_X;
	wire signed [15:0]two_comp_Y;
	reg  signed [16:0]sub_X;
	reg  signed [16:0]sub_Y;
	reg  signed  [31:0] mul_X;
	reg  signed  [31:0] mul_Y;
        reg  signed [32:0] add;
        reg [6:0] addr_wr;
	reg [6:0] check;
	

	reg [`WDATA_W-1:0] distances[`K_NUM_DATA_PTS-1:0];
	
	
	`SIGNAL(KN1,`WDATA_W)
	`SIGNAL(KN2,`WDATA_W)
	`SIGNAL(KN3,`WDATA_W)
	`SIGNAL(KN4,`WDATA_W)
	`SIGNAL(KN5,`WDATA_W)
	`SIGNAL(KN6,`WDATA_W)
	
	`SIGNAL(IN1,`K_NUM_DATA_PTS_BIT)
	`SIGNAL(IN2,`K_NUM_DATA_PTS_BIT)
	`SIGNAL(IN3,`K_NUM_DATA_PTS_BIT)
	`SIGNAL(IN4,`K_NUM_DATA_PTS_BIT)
	`SIGNAL(IN5,`K_NUM_DATA_PTS_BIT)
	`SIGNAL(IN6,`K_NUM_DATA_PTS_BIT)
	
	`SIGNAL(kn_1,`WDATA_W)
	`SIGNAL(kn_2,`WDATA_W)
	`SIGNAL(kn_3,`WDATA_W)
	`SIGNAL(kn_4,`WDATA_W)
	`SIGNAL(kn_5,`WDATA_W)
	`SIGNAL(kn_6,`WDATA_W)
	
	`SIGNAL(in_1,`K_NUM_DATA_PTS_BIT)
	`SIGNAL(in_2,`K_NUM_DATA_PTS_BIT)
	`SIGNAL(in_3,`K_NUM_DATA_PTS_BIT)
	`SIGNAL(in_4,`K_NUM_DATA_PTS_BIT)
	`SIGNAL(in_5,`K_NUM_DATA_PTS_BIT)
	`SIGNAL(in_6,`K_NUM_DATA_PTS_BIT)
	
	integer i;
	//TEST AND DATA POINTS HAS BOTH X AND Y CO-ORDINATE IN ONE REG 16BIT MSBs  X  16 BIT LSBb ARE Y
	always @ (posedge clk or posedge rst)
	begin
		if(rst)
		begin
			sub_X<= 17'd0;
			sub_Y<= 17'd0;
			mul_X<= 32'd0;
			mul_Y<= 32'd0;
			add <=  33'd0;
			addr_wr<= 7'd0;
			check  <=7'd0;
			kn_1<=32'd0;
			kn_2<=32'd0;
			kn_3<=32'd0;
			kn_4<=32'd0;
			kn_5<=32'd0;
			kn_6<=32'd0;
			in_1<=7'd0;
			in_2<=7'd0;
			in_3<=7'd0;
			in_4<=7'd0;
			in_5<=7'd0;
			in_6<=7'd0;
	
			for (i = 0; i <= (`K_NUM_DATA_PTS-1); i = i + 1) begin distances[i] <= 0; end
		end
		else
		begin
			if(KNN_START_DP)
			begin
				sub_X<= KNN_TEST_PT_DP[31:16] - KNN_DATA_PT_DP[31:16];
				sub_Y<= KNN_TEST_PT_DP[15:0] -  KNN_DATA_PT_DP[15:0];
				if(sub_X[15])
				begin
					
					mul_X<= two_comp_X*two_comp_X;
				end	
				else
				begin
					mul_X<= sub_X[15:0] * sub_X[15:0];
				end
				if(sub_Y[15])
				begin
					
					mul_Y<= two_comp_Y*two_comp_Y;
				end
				else
				begin
					mul_Y<= sub_Y[15:0] * sub_Y[15:0];
				end
				add <= mul_X + mul_Y;
				check <=check+1;
				if(check>=3)
				begin
					distances[addr_wr]<=add[31:0];
					addr_wr<=addr_wr+1;
					
					if(addr_wr<=7'd5)
					begin	 
						if(addr_wr==0)
						begin
							kn_1<=add[31:0];
							in_1<=addr_wr;
						end
						else if(addr_wr==1)
						begin
							if(add[31:0]<kn_1)
							begin
								kn_1<=add[31:0];
								kn_2<=kn_1;
								in_1<=addr_wr;
								in_2<=in_1;
							end
							else 
							begin
								kn_2<=add[31:0];
								in_2<=addr_wr;
							end
						end
						else if(addr_wr==2)
						begin
							if(add[31:0]<kn_1)
							begin
								kn_1<=add[31:0];
								kn_2<=kn_1;
								kn_3<=kn_2;
								in_1<=addr_wr;
								in_2<=in_1;
								in_3<=in_2;
							end
							else if (add[31:0]<kn_2)
							begin
								kn_2<=add[31:0];
								kn_3<=kn_2;
								in_2<=addr_wr;
								in_3<=in_2;
							end
							else
							begin
								kn_3<=add[31:0];
								in_3<=addr_wr;
							end
						end
						else if(addr_wr==3)
						begin
							if(add[31:0]<kn_1)
							begin
								kn_1<=add[31:0];
								kn_2<=kn_1;
								kn_3<=kn_2;
								kn_4<=kn_3;
								in_1<=addr_wr;
								in_2<=in_1;
								in_3<=in_2;
								in_4<=in_3;
							end
							else if (add[31:0]<kn_2)
							begin
								kn_2<=add[31:0];
								kn_3<=kn_2;
								kn_4<=kn_3;
								in_2<=addr_wr;
								in_3<=in_2;
								in_4<=in_3;
							end
							else if (add[31:0]<kn_3)
							begin
								kn_3<=add[31:0];
								kn_4<=kn_3;
								in_3<=addr_wr;
								in_4<=in_3;
							end
							else
							begin
								kn_4<=add[31:0];
								in_4<=addr_wr;
							end
						end
						
						else if(addr_wr==4)
						begin
							if(add[31:0]<kn_1)
							begin
								kn_1<=add[31:0];
								kn_2<=kn_1;
								kn_3<=kn_2;
								kn_4<=kn_3;
								kn_5<=kn_4;
								in_1<=addr_wr;
								in_2<=in_1;
								in_3<=in_2;
								in_4<=in_3;
								in_5<=in_4;
							end
							else if (add[31:0]<kn_2)
							begin
								kn_2<=add[31:0];
								kn_3<=kn_2;
								kn_4<=kn_3;
								kn_5<=kn_4;
								in_2<=addr_wr;
								in_3<=in_2;
								in_4<=in_3;
								in_5<=in_4;
							end
							else if (add[31:0]<kn_3)
							begin
								kn_3<=add[31:0];
								kn_4<=kn_3;
								kn_5<=kn_4;
								in_3<=addr_wr;
								in_4<=in_3;
								in_5<=in_4;
							end
							else if (add[31:0]<kn_4)
							begin
								kn_4<=add[31:0];
								kn_5<=kn_4;
								in_4<=addr_wr;
								in_5<=in_4;
							end
							else 
							begin
								kn_5<=add[31:0];
								in_5<=addr_wr;
							end
						end
						
						else if(addr_wr==5)
						begin
							if(add[31:0]<kn_1)
							begin
								kn_1<=add[31:0];
								kn_2<=kn_1;
								kn_3<=kn_2;
								kn_4<=kn_3;
								kn_5<=kn_4;
								kn_6<=kn_5;
								in_1<=addr_wr;
								in_2<=in_1;
								in_3<=in_2;
								in_4<=in_3;
								in_5<=in_4;
								in_6<=in_5;
							end
							else if (add[31:0]<kn_2)
							begin
								kn_2<=add[31:0];
								kn_3<=kn_2;
								kn_4<=kn_3;
								kn_5<=kn_4;
								kn_6<=kn_5;
								in_2<=addr_wr;
								in_3<=in_2;
								in_4<=in_3;
								in_5<=in_4;
								in_6<=in_5;
							end
							else if (add[31:0]<kn_3)
							begin
								kn_3<=add[31:0];
								kn_4<=kn_3;
								kn_5<=kn_4;
								kn_6<=kn_5;
								in_3<=addr_wr;
								in_4<=in_3;
								in_5<=in_4;
								in_6<=in_5;
							end
							else if (add[31:0]<kn_4)
							begin
								kn_4<=add[31:0];
								kn_5<=kn_4;
								kn_6<=kn_5;
								in_4<=addr_wr;
								in_5<=in_4;
								in_6<=in_5;
								
							end
							else if(add[31:0]<kn_5)
							begin
								kn_5<=add[31:0];
								kn_6<=kn_5;
								in_5<=addr_wr;
								in_6<=in_5;
							end
							else 
							begin
								kn_6<=add[31:0];
								in_6<=addr_wr;
							end
						end
					end
					else if(addr_wr>7'd5)
					begin
						if(add[31:0]<kn_1)
						begin
							kn_1<=add[31:0];
							kn_2<=kn_1;
							kn_3<=kn_2;
							kn_4<=kn_3;
							kn_5<=kn_4;
							kn_6<=kn_5;
							in_1<=addr_wr;
							in_2<=in_1;
							in_3<=in_2;
							in_4<=in_3;
							in_5<=in_4;
							in_6<=in_5;
						end
						else if (add[31:0]<kn_2)
						begin
							kn_2<=add[31:0];
							kn_3<=kn_2;
							kn_4<=kn_3;
							kn_5<=kn_4;
							kn_6<=kn_5;
							in_2<=addr_wr;
							in_3<=in_2;
							in_4<=in_3;
							in_5<=in_4;
							in_6<=in_5;
						end
						else if (add[31:0]<kn_3)
						begin
							kn_3<=add[31:0];
							kn_4<=kn_3;
							kn_5<=kn_4;
							kn_6<=kn_5;
							in_3<=addr_wr;
							in_4<=in_3;
							in_5<=in_4;
							in_6<=in_5;
						end
						else if (add[31:0]<kn_4)
						begin
							kn_4<=add[31:0];
							kn_5<=kn_4;
							kn_6<=kn_5;
							in_4<=addr_wr;
							in_5<=in_4;
							in_6<=in_5;
						end
						else if(add[31:0]<kn_5)
						begin
							kn_5<=add[31:0];
							kn_6<=kn_5;
							in_5<=addr_wr;
							in_6<=in_5;
						end
						else if(add[31:0]<kn_6)
						begin
							kn_6<=add[31:0];
							in_6<=addr_wr;
						end
					end
				end
			end
		 	else
			begin
				sub_X<= 17'd0;
				sub_Y<= 17'd0;
				mul_X<= 32'd0;
				mul_Y<= 32'd0;
				add <=  33'd0;
				addr_wr<=0;
				check<=0;
					
				
			end 
		end
	end
	
	assign two_comp_X = ((~sub_X[15:0])+16'b0000_0000_0000_0001);
	assign two_comp_Y =((~sub_Y[15:0])+16'b0000_0000_0000_0001);
	`REG_RE(clk,rst,0, KNN_SAMPLE_DP,KN1,kn_1)
	`REG_RE(clk,rst,0, KNN_SAMPLE_DP,KN2,kn_2)
	`REG_RE(clk,rst,0, KNN_SAMPLE_DP,KN3,kn_3)
	`REG_RE(clk,rst,0, KNN_SAMPLE_DP,KN4,kn_4)
	`REG_RE(clk,rst,0, KNN_SAMPLE_DP,KN5,kn_5)
	`REG_RE(clk,rst,0, KNN_SAMPLE_DP,KN6,kn_6)
	
	`REG_RE(clk,rst,0, KNN_SAMPLE_DP,IN1,in_1)
	`REG_RE(clk,rst,0, KNN_SAMPLE_DP,IN2,in_2)
	`REG_RE(clk,rst,0, KNN_SAMPLE_DP,IN3,in_3)
	`REG_RE(clk,rst,0, KNN_SAMPLE_DP,IN4,in_4)
	`REG_RE(clk,rst,0, KNN_SAMPLE_DP,IN5,in_5)
	`REG_RE(clk,rst,0, KNN_SAMPLE_DP,IN6,in_6)
	
	`SIGNAL2OUT(KN1_OUT,KN1)
	`SIGNAL2OUT(KN2_OUT,KN2)
	`SIGNAL2OUT(KN3_OUT,KN3)
	`SIGNAL2OUT(KN4_OUT,KN4)
	`SIGNAL2OUT(KN5_OUT,KN5)
	`SIGNAL2OUT(KN6_OUT,KN6)
	
	`SIGNAL2OUT(IN1_OUT,IN1)
	`SIGNAL2OUT(IN2_OUT,IN2)
	`SIGNAL2OUT(IN3_OUT,IN3)
	`SIGNAL2OUT(IN4_OUT,IN4)
	`SIGNAL2OUT(IN5_OUT,IN5)
	`SIGNAL2OUT(IN6_OUT,IN6)
endmodule 
