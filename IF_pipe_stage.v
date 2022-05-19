`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/10/2020 10:16:28 AM
// Design Name: 
// Module Name: IF_pipe_stage
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


module IF_pipe_stage(
    input clk, reset,
    input en,
    input [9:0] branch_address,
    input [9:0] jump_address,
    input branch_taken,
    input jump,
    output [9:0] pc_plus4,
    output [31:0] instr
    );
    
// write your code here
reg [9:0] pc;
wire [9:0] nxt_pc;
wire [9:0] pc_br_address;
wire [9:0] pc4;

assign pc4 = pc + 10'b0000000100;
assign pc_plus4 = pc4;

always @(posedge clk or posedge reset) begin
    if(reset) 
        pc <= 10'b0000000000;
    else if(en)
        pc <= nxt_pc;
end

mux2 #(.mux_width(10)) branch_mux
    (.a(pc4), 
     .b(branch_address), 
     .sel(branch_taken), 
     .y(pc_br_address));

mux2 #(.mux_width(10)) jump_mux
    (.a(pc_br_address),
     .b(jump_address),
     .sel(jump),
     .y(nxt_pc));
     
instruction_mem inst_mem(.read_addr(pc), .data(instr));
    

           
endmodule
