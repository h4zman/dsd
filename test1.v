module test1 (clk, reset, p1, ldr, ir, seg, seg2, led1,led2,led3, arduino);

input clk, reset, ldr, ir;
output reg p1;
reg [2:0] cstate, nstate;
output [6:0] seg;
output [6:0] seg2;
output reg led1,led2,led3, arduino;
reg [6:0] seg;
reg [6:0] seg2;

parameter s1 = 2'b00;
parameter s2 = 2'b01;

always @*
begin

if (ir == 1) begin
 arduino = 1'b1;
 end
else
begin
 arduino = 1'b0;
end
end
always @*
begin
	case(cstate)
	s1: 
	begin	
		p1 = 1'b0;
		nstate = s2;
		end
	s2: 
	begin	
		p1 = 1'b1;
		nstate = s1;
		end
endcase
end

always @ (posedge clk, posedge reset)
begin
	if (reset == 1)
	cstate <= s1;
	else
	cstate <= nstate;
end

//always block for converting bcd digit into 7 segment format
    always @*
    begin
        if (ldr == 1) begin
            seg = 7'b1000000;
				seg2 =7'b1000000;
				led1 = 1'b0;
				led2 = 1'b0;
				led3 = 1'b1;
				end
			else
			begin
            seg = 7'b1001111;
				seg2 = 7'b1000000;
				led3 = 1'b0;
				led2 = 1'b0;
				led1 = 1'b1;
			end
    end
endmodule
