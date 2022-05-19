`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 1/12/2020 01:37:07 PM
// Design Name: 
// Module Name: dff_PC
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


module dff_PC(D, clock, preset, clear, Q);
input D, clock, preset, clear;
output Q;

reg Q;
always@(posedge clock or posedge preset or posedge clear)
begin
    if(preset)
        Q <= 1;
    else if(clear)
        Q <= 0;
    else
        Q <= D;
end
endmodule
