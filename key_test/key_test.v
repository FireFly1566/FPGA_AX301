
`timescale 1ns/1ps

module key_test(
				clk,	//50MHz
				key_in, //输入按键信号（reset,key1~3）
				led_out
);
//--------------------------------------------
//Port declarations
//---------------------------------------------------
input clk;
input [3:0] key_in;
output [3:0] led_out;

wire rst_n=1'b1;

reg [19:0] count;
reg [3:0] key_scan;

//-----------------------------------------
//20ms扫描一次，采样频率小于按键毛刺频率，相当于滤除掉了高频毛刺信号
//----------------------------------------------------
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n) count<=20'd0;
	else 
	begin
		if(count==20'd999_999) //20ms扫描一次按键，20ms计数,(50M/50-1=999_999)
			begin
				count<=20'd0; //计数器计到20ms,
				key_scan<=key_in; //采样按键输入电平
			end
		else
			count<=count+20'd1;
	end	
end

//按键信号锁存一个信号节拍
reg [3:0] key_scan_r;
always @(posedge clk)
	key_scan_r<=key_scan;
	
wire [3:0] flag_key=key_scan_r[3:0] & (~key_scan[3:0]);

//LED灯控制，按键按下时，相关的LED输出翻转
reg [3:0] temp_led;
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n) temp_led<=4'b0000;// LED灭
	else
		begin
			if(flag_key[0]) temp_led[0]<=~temp_led[0];
			if(flag_key[1]) temp_led[1]<=~temp_led[1];
			if(flag_key[2]) temp_led[2]<=~temp_led[2];
			if(flag_key[3]) temp_led[3]<=~temp_led[3];
		end
end

assign led_out=temp_led;


endmodule
