`timescale 1ns/1ps

module tb();
//clk and reset inputs
reg clk;
reg reset;

//inputs of design
reg [3:0]i_str;
reg [7:0]i_data;
reg [1:0]ctrl;

//outputs of design
wire [7:0]o_num;

mk_SEARCH dut(.CLK(clk),.RST_N(reset),.str(i_str),.data(i_data),.num_matches(o_num),.search_control(ctrl));

//generate clock signal
initial begin
 clk=1'b0;
 forever #5 clk=~clk;
end

//reset the system
initial begin
reset =1'b0;
#10
reset=1'b1;ctrl=2'b00;
end

//test stimulus
initial begin
$dumpfile("tb_new.vcd");
$dumpvars(0,tb);
$monitor("time=%t,o_num=%h,i_str=%b,i_data=%b\n",$time,o_num,i_str,i_data);
#40 ctrl=2'b01;reset=1'b1;i_str=4'b1001; i_data=8'b00100101;	//test stimulus
#30 reset=1'b0;ctrl=2'b00;
#40 ctrl=2'b01;reset=1'b1;i_str=4'b1000; i_data=8'b10001000;
#200
$display("time=%t,i_data=%h,o_num=%h\n",$time,i_data,o_num); 
$finish;
end
endmodule


