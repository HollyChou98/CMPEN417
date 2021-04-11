`timescale 1ns / 1ps


module very_simple_switch #(
    parameter DATA_WIDTH = 64,
    parameter INPUT_QTY = 4,
    parameter OUTPUT_QTY = 4
    )
(
    input clk,
    input reset,
    
    input [INPUT_QTY-1:0] data_in_valid,
    input [INPUT_QTY-1:0][DATA_WIDTH-1:0]  data_in,
    input [INPUT_QTY-1:0][$clog2(OUTPUT_QTY)-1:0] data_in_destination ,
    
    output logic [OUTPUT_QTY-1:0] data_out_valid,
    output logic [OUTPUT_QTY-1:0][DATA_WIDTH-1:0]data_out ,
    output [2:0] data_out_valid_0_reg
);

fifo fifo_0(.din(din_0),.push(push_0),.full(full_0),.dout(dout_0),.pop(pop_0),.empty(empty_0),.clk(clk),.reset(reset));
fifo fifo_1(.din(din_1),.push(push_1),.full(full_1),.dout(dout_1),.pop(pop_1),.empty(empty_1),.clk(clk),.reset(reset));
fifo fifo_2(.din(din_2),.push(push_2),.full(full_2),.dout(dout_2),.pop(pop_2),.empty(empty_2),.clk(clk),.reset(reset));
fifo fifo_3(.din(din_3),.push(push_3),.full(full_3),.dout(dout_3),.pop(pop_3),.empty(empty_3),.clk(clk),.reset(reset));


parameter DWIDTH     = 64;
parameter LOG2_DEPTH = 4;
reg [DWIDTH-1:0]  din_1, din_2, din_3, din_0, dout_0, dout_1, dout_2, dout_3;
reg  push_1, push_2,push_3,push_0, pop_0, pop_1, pop_2, pop_3;
reg  full;
reg  [DWIDTH-1:0] dout;
reg  pop;
reg  empty;
reg  clk;
reg  reset;

reg [2:0] data_out_valid_0_reg, data_out_valid_1_reg, data_out_valid_2_reg, data_out_valid_3_reg ;
//assign data_out_valid[0] = data_out_valid_0_reg[2];
//assign data_out_valid[1] = data_out_valid_1_reg[2];
//assign data_out_valid[2] = data_out_valid_2_reg[2];
//assign data_out_valid[3] = data_out_valid_3_reg[2];


int i;

always@(posedge clk)
begin
    if(reset)
    begin
        for(i=0; i<4; i=i+1)
        begin
        data_out[i] <= 64'b0;
        data_out_valid[i] <= 1'b0;
        end
        
        data_out_valid_0_reg[0] <= 4'b0;        
        data_out_valid_1_reg[0] <= 4'b0;
        data_out_valid_2_reg[0] <= 4'b0;
        data_out_valid_3_reg[0] <= 4'b0;
        
        data_out_valid_0_reg[1] <= 4'b0;        
        data_out_valid_1_reg[1] <= 4'b0;
        data_out_valid_2_reg[1] <= 4'b0;
        data_out_valid_3_reg[1] <= 4'b0;
        
        data_out_valid_0_reg[2] <= 4'b0;        
        data_out_valid_1_reg[2] <= 4'b0;
        data_out_valid_2_reg[2] <= 4'b0;
        data_out_valid_3_reg[2] <= 4'b0;
    end
    
    else begin 
    for(i=0; i<4; i=i+1)
    begin
        case(data_in_destination[i])//push to respective fifo
        8'd0: 
            begin
            if(data_in_valid[i]==1)
            begin
                push_0 <= 1'b1;
                din_0 <= data_in[i];
                data_out_valid_0_reg[0] <= 4'b0001; 
               // data_out_valid_0_reg[1] <= data_out_valid_0_reg[0];
               // data_out_valid_0_reg[2] <= data_out_valid_0_reg[1];
            end
            else begin
                data_out_valid_0_reg[0] <= 4'b0000; 
              //  data_out_valid_0_reg[1] <= data_out_valid_0_reg[0];
              //  data_out_valid_0_reg[2] <= data_out_valid_0_reg[1];
            end
            
            if(empty_0==0)//fifo not empty
            begin
                pop_0 <= 1'b1;
                data_out[0] <= dout_0;
              //  data_out_valid[0] <= 1'b1;
            end
            else begin
                data_out[0] <= 1'b0;
            end

               
            end
        8'd1:
            begin
            if(data_in_valid[i]==1)
            begin
                push_1 <= 1'b1;
                din_1 <= data_in[i];
                data_out_valid_1_reg[0] <= 4'b1; 
               // data_out_valid_1_reg[1] <= data_out_valid_1_reg[0];
               // data_out_valid_1_reg[2] <= data_out_valid_1_reg[1];
            end
            else begin
                data_out_valid_1_reg[0] <= 4'b0; 
              //  data_out_valid_1_reg[1] <= data_out_valid_1_reg[0];
              //  data_out_valid_1_reg[2] <= data_out_valid_1_reg[1];
            end
            
            if(empty_1==0)//fifo not empty
            begin
                pop_1 <= 1'b1;
                data_out[1] <= dout_1;
             //   data_out_valid[1] <= 1'b1;
            end
            else begin
                data_out[1] <= 1'b0;
            end
                
            end
        8'd2:
            begin
            if(data_in_valid[i]==1)
            begin
                push_2 <= 1'b1;
                din_2 <= data_in[i];
                data_out_valid_2_reg[0] <= 4'b1; 
              //  data_out_valid_2_reg[1] <= data_out_valid_2_reg[0];
              //  data_out_valid_2_reg[2] <= data_out_valid_2_reg[1]; 
            end
            else begin
                data_out_valid_2_reg[0] <= 4'b0; 
              //  data_out_valid_2_reg[1] <= data_out_valid_2_reg[0];
              //  data_out_valid_2_reg[2] <= data_out_valid_2_reg[1];
            end
            
            if(empty_2==0)//fifo not empty
            begin
                pop_2 <= 1'b1;
                data_out[2] <= dout_2;
             //   data_out_valid[2] <= 1'b1;
            end
            else begin
                data_out[2] <= 1'b0;
            end
                
            end
        8'd3:
            begin
            if(data_in_valid[i]==1)
            begin
                push_3 <= 1'b1;
                din_3 <= data_in[i];
                data_out_valid_3_reg[0] <= 4'b1; 
             //   data_out_valid_3_reg[1] <= data_out_valid_3_reg[0];
             //   data_out_valid_3_reg[2] <= data_out_valid_3_reg[1];
            end
            else begin
                data_out_valid_3_reg[0] <= 4'b0; 
             //   data_out_valid_3_reg[1] <= data_out_valid_3_reg[0];
             //   data_out_valid_3_reg[2] <= data_out_valid_3_reg[1];
            end
            
            if(empty_3==0)//fifo not empty
            begin
                pop_3 <= 1'b1;
                data_out[3] <= dout_3;
             //   data_out_valid[3] <= 1'b1;
            end
            else begin
                data_out[3] <= 1'b0;
            end
            end
        default: 
            begin
                data_out[i] <= 10'd1000;
            end
        endcase    
        
                data_out_valid_0_reg[1] <= data_out_valid_0_reg[0];
                data_out_valid_0_reg[2] <= data_out_valid_0_reg[1];
                data_out_valid[0] <= data_out_valid_0_reg[2];
                
                data_out_valid_1_reg[1] <= data_out_valid_1_reg[0];
                data_out_valid_1_reg[2] <= data_out_valid_1_reg[1];
                data_out_valid[1] <= data_out_valid_1_reg[2];
        
                data_out_valid_2_reg[1] <= data_out_valid_2_reg[0];
                data_out_valid_2_reg[2] <= data_out_valid_2_reg[1];
                data_out_valid[2] <= data_out_valid_2_reg[2];
                
                data_out_valid_3_reg[1] <= data_out_valid_3_reg[0];
                data_out_valid_3_reg[2] <= data_out_valid_3_reg[1];
                data_out_valid[3] <= data_out_valid_3_reg[2];
    end
    end
end

endmodule