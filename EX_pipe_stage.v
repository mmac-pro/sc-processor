`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/10/2020 11:30:41 AM
// Design Name: 
// Module Name: EX_pipe_stage
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


module EX_pipe_stage(
    input [31:0] id_ex_instr,
    input [31:0] reg1, reg2,
    input [31:0] id_ex_imm_value,
    input [31:0] ex_mem_alu_result,
    input [31:0] mem_wb_write_back_result,
    input id_ex_alu_src,
    input [1:0] id_ex_alu_op,
    input [1:0] Forward_A, Forward_B,
    output [31:0] alu_in2_out,
    output [31:0] alu_result
    );
    
    // Write your code here
    wire [31:0] reg1_output;
    wire [31:0] reg2_output;
    wire [3:0] w_alu_control;
    wire [31:0] w_alu_in2_out;
    wire zero;
    
    assign alu_in2_out = w_alu_in2_out;
    
    mux4 #(.mux_width(32)) reg1_mux (
        .a(reg1),
        .b(mem_wb_write_back_result),
        .c(ex_mem_alu_result),
        .d(32'b0),
        .sel(Forward_A),
        .y(reg1_output));
    
   mux4 #(.mux_width(32)) reg2_mux (
        .a(reg2),
        .b(mem_wb_write_back_result),
        .c(ex_mem_alu_result),
        .d(32'b0),
        .sel(Forward_B),
        .y(w_alu_in2_out));
   
   ALUControl alu_control (
        .ALUOp(id_ex_alu_op),
        .Function(id_ex_instr[5:0]),
        .ALU_Control(w_alu_control));
   
   mux2 #(.mux_width(32)) alu_mux (
        .a(w_alu_in2_out),
        .b(id_ex_imm_value),
        .sel(id_ex_alu_src),
        .y(reg2_output));
        
   ALU ALU (
        .a(reg1_output),
        .b(reg2_output),
        .alu_control(w_alu_control),
        .zero(zero),
        .alu_result(alu_result));    
       
endmodule
