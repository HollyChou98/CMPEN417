`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2021 05:09:07 PM
// Design Name: 
// Module Name: sim
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2021 09:25:21 PM
// Design Name: 
// Module Name: basic_simulation
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module testbench
#(
 parameter INPUT_QTY=4,
 parameter OUTPUT_QTY=4,
 parameter DATA_WIDTH=64
);


reg clk;
reg reset;
reg [INPUT_QTY-1:0] data_in_valid;
reg [INPUT_QTY-1:0][DATA_WIDTH-1:0]data_in;
reg [INPUT_QTY-1:0][$clog2(OUTPUT_QTY)-1:0]data_in_destination ;

wire [OUTPUT_QTY-1:0] data_out_valid;
wire [OUTPUT_QTY-1:0][DATA_WIDTH-1:0]data_out ; 

reg [2:0] data_out_valid_0_reg;

integer i;
integer k;

initial begin
    clk = 0;
    reset = 1;
    k=0;
 /*   data_in_valid = {INPUT_QTY{1'b0}};
    

    for( i=0; i<INPUT_QTY; i=i+1)
    data_in[i]={DATA_WIDTH{1'b0}};
    for( i=0; i<INPUT_QTY; i=i+1)
    data_in_destination[i]={DATA_WIDTH{1'b0}};
    
    data_in[2'b11]=6;
    data_in[1]=1;
    data_in_destination[0]=0;
    data_in_destination[1]=1;*/
    
    #9;
    reset = 0;
    #50;
end 

always
begin
    clk = ~clk;
    #2;
end

very_simple_switch vss(
 .clk(clk), .reset(reset), .data_in_valid(data_in_valid), .data_in(data_in), .data_in_destination(data_in_destination), .data_out_valid(data_out_valid), 
 .data_out(data_out),.data_out_valid_0_reg(data_out_valid_0_reg) );



always@(posedge clk)
    if(reset)
    begin
    for( i=0; i<INPUT_QTY; i=i+1)
    begin
        data_in[i] = 0;
        data_in_destination[i] = 0;
        data_in_valid[i] = 0;
    end
    end else begin
        k++;
        if(data_in[1] == 1)
        begin
            data_in_valid = 0;
        end else begin
        for( i=0; i<4; i=i+1)
        begin
            data_in[i] = k+i; //4-i;
            data_in_destination[i] = 0;//3-i;
            data_in_valid[i] = 1;
        end
        end
    end
    


 endmodule