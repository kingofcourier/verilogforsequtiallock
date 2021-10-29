`define sa 4'b0000
`define sb 4'b0001
`define sc 4'b0010
`define sd 4'b0011
`define se 4'b0100
`define sf 4'b0101
`define s_open 4'b0110
`define s_close 4'b0111
`define s_error 4'b1000

module lab3_top(SW,KEY,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,LEDR);
  input [9:0] SW;
  input [3:0] KEY;
  output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
  output [9:0] LEDR;
  wire [3:0] present_state; // optional: use these outputs for debugging on your DE1-SoC

state_machine module1 (SW,KEY,present_state);
decoder module2 (present_state,SW,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);



  // put your solution code here!
endmodule

module state_machine (SW,KEY,present_state);
input [9:0] SW;
input [3:0] KEY;
output[3:0]present_state;
reg[3:0]present_state;
always@(negedge KEY[0])
begin
if (KEY[3]==1'b0)begin
present_state=`sa;
end
else if(present_state==`s_error|present_state==`s_open|present_state==`s_close) begin
if(present_state==`s_error)
present_state=`s_error;
else if(present_state==`s_open)
present_state=`s_open;
else 
present_state=`s_close;
end
else if (SW[3:0]==4'b1010|SW[3:0]==4'b1011|SW[3:0]==4'b1100|SW[3:0]==4'b1101|SW[3:0]==4'b1110|SW[3:0]==4'b1111)
present_state=`s_error;
else
begin
case(present_state)
`sa:if(SW[3:0]==4'b0100)
present_state=`sb;
else
present_state=`s_close;
`sb:if(SW[3:0]==4'b0011)
present_state=`sc;
else
present_state[3:0]=`s_close;
`sc:if(SW[3:0]==4'b0010)
present_state[3:0]=`sd;
else
present_state[3:0]=`s_close;
`sd:if(SW[3:0]==4'b0111)
present_state[3:0]=`se;
else
present_state[3:0]=`s_close;
`se:if(SW[3:0]==4'b0011)
present_state[3:0]=`sf;
else
present_state[3:0]=`s_close;
`sf:if(SW[3:0]==4'b0001)
present_state[3:0]=`s_open;
else
present_state[3:0]=`s_close;
default: present_state[3:0]={4{1'bx}};

endcase
end
end
endmodule

module decoder(present_state,SW,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
input [3:0] present_state;
input [9:0] SW;
output [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
reg[6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
always@(*)
begin
case(present_state)
`s_error:
begin
HEX0[6:0]=7'b0101111;
HEX1[6:0]=7'b1000000;
HEX2[6:0]=7'b0101111;
HEX3[6:0]=7'b0101111;
HEX4[6:0]=7'b0000110;
HEX5[6:0]=7'b1111111;
end
`s_open:
begin
HEX0[6:0]=7'b0101011;
HEX1[6:0]=7'b0000110;
HEX2[6:0]=7'b0001100;
HEX3[6:0]=7'b1000000;
HEX4[6:0]=7'b1111111;
HEX5[6:0]=7'b1111111;
end
`s_close:
begin
HEX0[6:0]=7'b1000000;
HEX1[6:0]=7'b0000110;
HEX2[6:0]=7'b0010010;
HEX3[6:0]=7'b1000000;
HEX4[6:0]=7'b1000111;
HEX5[6:0]=7'b1000110;
end
default:
begin
HEX0[6]=(~SW[3]&~SW[2]&~SW[1]&~SW[0])|(~SW[3]&~SW[2]&~SW[1]&SW[0])|(~SW[3]&SW[2]&SW[1]&SW[0]);
HEX0[5]=(~SW[3]&~SW[2]&~SW[1]&SW[0])|(~SW[3]&~SW[2]&SW[1]&~SW[0])|(~SW[3]&~SW[2]&SW[1]&SW[0])|(~SW[3]&SW[2]&SW[1]&SW[0]);
HEX0[4]=(~SW[3]&~SW[2]&~SW[1]&SW[0])|(~SW[3]&~SW[2]&SW[1]&SW[0])|(~SW[3]&SW[2]&~SW[1]&~SW[0])|(~SW[3]&SW[2]&~SW[1]&SW[0])|(~SW[3]&SW[2]&SW[1]&SW[0])|(SW[3]&~SW[2]&~SW[1]&SW[0]);
HEX0[3]=(~SW[3]&~SW[2]&~SW[1]&SW[0])|(~SW[3]&SW[2]&~SW[1]&~SW[0])|(~SW[3]&SW[2]&SW[1]&SW[0]);
HEX0[2]=(~SW[3]&~SW[2]&SW[1]&~SW[0]);
HEX0[1]=(~SW[3]&SW[2]&~SW[1]&SW[0])|(~SW[3]&SW[2]&SW[1]&~SW[0]);
HEX0[0]=(~SW[3]&~SW[2]&~SW[1]&SW[0])|(~SW[3]&SW[2]&~SW[1]&~SW[0]);
HEX1[6:0]=7'b1111111;
HEX2[6:0]=7'b1111111;
HEX3[6:0]=7'b1111111;
HEX4[6:0]=7'b1111111;
HEX5[6:0]=7'b1111111;
end
endcase
end
endmodule


