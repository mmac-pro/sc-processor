`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 1/12/2020 04:48:21 PM
// Design Name: 
// Module Name: dff_SR
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

module dff_SR(D, clock, set, reset, Q);
    input D,clock,set,reset;
    output Q;
   
    reg Q;
    always@(posedge clock)
    begin
        if(set)
            Q <= 1;
        else if(reset)
            Q <= 0;
        else
            Q <= D;
    end  
endmodule
