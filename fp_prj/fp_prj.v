
module fp_prj(clk,
				rst_n,fm);

input clk; //50MHz
input rst_n;
output fm;  //蜂鸣器 0--响

reg[5:0] cnt;

always @(posedge clk or negedge rst_n)
	if(!rst_n) cnt<=6'd0;
	else if(cnt < 6'd49) cnt<=cnt+1'b1;
	else cnt<=6'd0;

assign fm=(cnt<=6'd24) ? 1'b0:1'b1;



endmodule