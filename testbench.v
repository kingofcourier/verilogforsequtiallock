`timescale 1 ps/ 1 ps
`define sa 4'b0000
`define sb 4'b0001
`define sc 4'b0010
`define sd 4'b0011
`define se 4'b0100
`define sf 4'b0101
`define s_open 4'b0110
`define s_close 4'b0111
`define s_error 4'b1000

module top_dut();
reg[9:0] SW;
reg[3:0] KEY;
reg error;
wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
wire [9:0] LEDR;
lab3_top dut3(SW,KEY,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,LEDR);

initial begin
KEY[0]=1;
#50;
forever begin
KEY[0]=0;#50;
KEY[0]=1;#50;
end
end
initial begin
KEY[3]=1'b0;
SW[3:0]=4'd0;
KEY[3]=1'b0;
SW[3:0]=4'd0;
error=1'b0;
#100;
if(HEX0[6:0]!==7'b1000000) begin 
$display("error is %b,expected %b",HEX0,7'b1000000);
error=1'b1;
end 
end
endmodule 
 
module state_machine_dut();
reg[9:0] SW;
reg[3:0] KEY;
reg error;
wire[3:0] present_state;
state_machine dut2(SW,KEY,present_state);
initial begin
KEY[0]=1;
#50;
forever begin
KEY[0]=0;#50;
KEY[0]=1;#50;
end
end
initial begin
KEY[3]=1'b0;
SW[3:0]=4'd0;
error=1'b0;
#100;
if (state_machine_dut.present_state!==`sa)
begin 
$display("error state is %b,expected %b",state_machine_dut.present_state,`sa);
error=1'b1;
end
KEY[3]=1'b1;
SW[3:0]=4'd4;
error=1'b0;
#100;
if (state_machine_dut.present_state!==`sb)
begin 
$display("error state is %b,expected %b",state_machine_dut.present_state,`sb);
error=1'b1;
end
KEY[3]=1'b1;
SW[3:0]=4'd3;
error=1'b0;
#100;
if (state_machine_dut.present_state!==`sc)
begin 
$display("error state is %b,expected %b",state_machine_dut.present_state,`sc);
error=1'b1;
end
KEY[3]=1'b1;
SW[3:0]=4'd2;
error=1'b0;
#100;
if (state_machine_dut.present_state!==`sd)
begin 
$display("error state is %b,expected %b",state_machine_dut.present_state,`sd);
error=1'b1;
end
KEY[3]=1'b1;
SW[3:0]=4'd7;
error=1'b0;
#100;
if (state_machine_dut.present_state!==`se)
begin 
$display("error state is %b,expected %b",state_machine_dut.present_state,`se);
error=1'b1;
end
KEY[3]=1'b1;
SW[3:0]=4'd3;
error=1'b0;
#100;
if (state_machine_dut.present_state!==`sf)
begin 
$display("error state is %b,expected %b",state_machine_dut.present_state,`sf);
error=1'b1;
end
KEY[3]=1'b1;
SW[3:0]=4'd1;
error=1'b0;
#100;
if (state_machine_dut.present_state!==`s_open)
begin 
$display("error state is %b,expected %b",state_machine_dut.present_state,`s_open);
error=1'b1;
end
KEY[3]=1'b1;
SW[3:0]=4'd10;
error=1'b0;
#100;
if (state_machine_dut.present_state!==`s_open)
begin 
$display("error state is %b,expected %b",state_machine_dut.present_state,`s_open);
error=1'b1;
end
KEY[3]=1'b0;
SW[3:0]=4'd0;
error=1'b0;
#100;
if (state_machine_dut.present_state!==`sa)
begin 
$display("error state is %b,expected %b",state_machine_dut.present_state,`sa);
error=1'b1;
end 
KEY[3]=1'b1;
SW[3:0]=4'd15;
error=1'b0;
#100;
if (state_machine_dut.present_state!==`s_error)
begin 
$display("error state is %b,expected %b",state_machine_dut.present_state,`s_error);
error=1'b1;
end
KEY[3]=1'b1;
SW[3:0]=4'd0;
error=1'b0;
#100;
if (state_machine_dut.present_state!==`s_error)
begin 
$display("error state is %b,expected %b",state_machine_dut.present_state,`s_error);
error=1'b1;
end
KEY[3]=1'b0;
SW[3:0]=4'd0;
error=1'b0;
#100;
if (state_machine_dut.present_state!==`sa)
begin 
$display("error state is %b,expected %b",state_machine_dut.present_state,`sa);
error=1'b1;
end
KEY[3]=1'b1;
SW[3:0]=4'd9;
error=1'b0;
#100;
if (state_machine_dut.present_state!==`s_close)
begin 
$display("error state is %b,expected %b",state_machine_dut.present_state,`s_close);
error=1'b1;
end 
KEY[3]=1'b1;
SW[3:0]=4'd10;
error=1'b0;
#100;
if (state_machine_dut.present_state!==`s_close)
begin 
$display("error state is %b,expected %b",state_machine_dut.present_state,`s_close);
error=1'b1;
end     
end
endmodule



module decoder_dut();
reg [3:0] present_state;
reg [9:0] SW;
wire[6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
decoder dut(present_state,SW,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
initial begin
SW[3:0]=4'd0;
present_state=`sa;
#100
SW[3:0]=4'd1;
$display ("in=%b,out=%b",SW,HEX0);
#100;
SW[3:0]=4'd2;
$display ("in=%b,out=%b",SW,HEX0);
#100;
SW[3:0]=4'd3;
$display ("in=%b,out=%b",SW,HEX0);
#100;
SW[3:0]=4'd4;
$display ("in=%b,out=%b",SW,HEX0);
#100;
SW[3:0]=4'd5;
$display ("in=%b,out=%b",SW,HEX0);
#100;
SW[3:0]=4'd6;
$display ("in=%b,out=%b",SW,HEX0);
#100;
SW[3:0]=4'd7;
$display ("in=%b,out=%b",SW,HEX0);
#100;
SW[3:0]=4'd8;
$display ("in=%b,out=%b",SW,HEX0);
#100;
SW[3:0]=4'd9;
$display ("in=%b,out=%b",SW,HEX0);
#100;
present_state=`sb;
SW[3:0]=4'd0; 
repeat(9)begin
#100
SW[3:0]=SW[3:0]+4'd1;
end
present_state=`sc;
SW[3:0]=4'd0; 
repeat(9)begin
#100
SW[3:0]=SW[3:0]+4'd1;
end
present_state=`sd;
SW[3:0]=4'd0; 
repeat(9)begin
#100
SW[3:0]=SW[3:0]+4'd1;
end
present_state=`se;
SW[3:0]=4'd0; 
repeat(9)begin
#100
SW[3:0]=SW[3:0]+4'd1;
end
present_state=`sf;
SW[3:0]=4'd0; 
repeat(9)begin
#100
SW[3:0]=SW[3:0]+4'd1;
end
present_state=`s_error;
SW[3:0]=4'd0; 
repeat(9)begin
#100
SW[3:0]=SW[3:0]+4'd1;
end
present_state=`s_open;
SW[3:0]=4'd0; 
repeat(9)begin
#100
SW[3:0]=SW[3:0]+4'd1;
end
present_state=`s_close;
SW[3:0]=4'd0; 
repeat(9)begin
#100
SW[3:0]=SW[3:0]+4'd1;
end
end
endmodule 
