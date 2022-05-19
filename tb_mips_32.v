`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2021 11:22:04 AM
// Design Name: 
// Module Name: tb_mips_32
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


module tb_mips_32;
      reg clk;  
      reg reset;  
      // Outputs  

      wire [31:0] result;
      // Instantiate the Unit Under Test (UUT)  
      mips_32 uut (  
           .clk(clk),   
           .reset(reset),     
           .result(result)    
      );  
      
      real points = 0;
      

      initial begin  
           clk = 0;  
           forever #10 clk = ~clk;  
      end  
      initial begin  
           // Initialize Inputs  
 
           reset = 1;  
           // Wait 100 ns for global reset to finish  
           #100;  
           reset = 0;  
           // store some data in data memory
           uut.data_mem.ram[0]= 32'b00000000000000000000000000000001;// 00000001
           uut.data_mem.ram[1]= 32'b00001111110101110110111000010000;// 0fd76e10 
           uut.data_mem.ram[2]= 32'b01011010000000000100001010011011;// 5a00429b 
           uut.data_mem.ram[3]= 32'b00010100001100110011111111111100;// 14333ffc 
           uut.data_mem.ram[4]= 32'b00110010000111111110110111001011;// 321fedcb 
           uut.data_mem.ram[5]= 32'b10000000000000000000000000000000;// 80000000 
           uut.data_mem.ram[6]= 32'b10010000000100101111110101100101;// 9012fd65
           uut.data_mem.ram[7]= 32'b10101011110000000000001000110111;// abc00237
           uut.data_mem.ram[8]= 32'b10110101010010111100000000110001;// b54bc031
           uut.data_mem.ram[9]= 32'b11000001100001111010011000000110;// c187a606 
          
          #1500; 

          
          if(uut.data_mem.ram[11]==32'h0fd76e00) begin $display("NO DEPENDENCY ANDI 	success!\n"); points= points+1; end else $display("NO DEPENDENCY ANDI 	failed!\n");
          if(uut.data_mem.ram[12]==32'hf02891ee) begin $display("NO DEPENDENCY NOR  	success!\n"); points= points+1; end else $display("NO DEPENDENCY NOR  	failed!\n");
          if(uut.data_mem.ram[13]==32'h00000001) begin $display("NO DEPENDENCY SLT  	success!\n"); points= points+1; end else $display("NO DEPENDENCY SLT  	failed!\n");
          if(uut.data_mem.ram[14]==32'h7ebb7080) begin $display("NO DEPENDENCY SLL  	success!\n"); points= points+1; end else $display("NO DEPENDENCY SLL  	failed!\n");
          if(uut.data_mem.ram[15]==32'h00000000) begin $display("NO DEPENDENCY SRL  	success!\n"); points= points+1; end else $display("NO DEPENDENCY SRL  	failed!\n");
          if(uut.data_mem.ram[16]==32'hfe000000) begin $display("NO DEPENDENCY SRA  	success!\n"); points= points+1; end else $display("NO DEPENDENCY SRA  	failed!\n");
          if(uut.data_mem.ram[17]==32'h00000000) begin $display("NO DEPENDENCY XOR  	success!\n"); points= points+1; end else $display("NO DEPENDENCY XOR  	failed!\n");
          if(uut.data_mem.ram[18]==32'h0fd76e10) begin $display("NO DEPENDENCY MULT 	success!\n"); points= points+1; end else $display("NO DEPENDENCY MULT 	failed!\n");
          if(uut.data_mem.ram[19]==32'h0fd76e10) begin $display("NO DEPENDENCY DIV  	success!\n"); points= points+1; end else $display("NO DEPENDENCY DIV  	failed!\n");
          
          if(uut.data_mem.ram[20]==32'h00000d61) begin $display("ANDI No Forwarding       success!\n"); points= points+1; end else $display("ANDI No Forwarding     failed!\n");
          if(uut.data_mem.ram[21]==32'hf028908e) begin $display("Forward EX/MEM to EX B   success!\n"); points= points+1; end else $display("Forward EX/MEM to EX B failed!\n");
          if(uut.data_mem.ram[22]==32'h00000001) begin $display("Forward MEM/WB to EX A	success!\n"); points= points+1; end else $display("Forward MEM/WB to EX A	failed!\n");
          if(uut.data_mem.ram[23]==32'h5faca000) begin $display("SLL  No Forwarding		success!\n"); points= points+1; end else $display("SLL  No Forwarding		failed!\n");
          if(uut.data_mem.ram[24]==32'h00bf5940) begin $display("Forward EX/MEM to EX A	success!\n"); points= points+1; end else $display("Forward EX/MEM to EX A	failed!\n");
          if(uut.data_mem.ram[25]==32'h17eb2800) begin $display("Forward MEM/WB to EX A	success!\n"); points= points+1; end else $display("Forward MEM/WB to EX A	failed!\n");
          if(uut.data_mem.ram[26]==32'h9fc59375) begin $display("XOR  No Forwarding		success!\n"); points= points+1; end else $display("XOR  No Forwarding		failed!\n");
          if(uut.data_mem.ram[27]==32'he4e43c50) begin $display("MULT No Forwarding		success!\n"); points= points+1; end else $display("MULT No Forwarding		failed!\n");
          if(uut.data_mem.ram[28]==32'h00000000) begin $display("Forward MEM/WB to EX B	success!\n"); points= points+1; end else $display("Forward MEM/WB to EX B	failed!\n");
          
          // Data Hazard is the result of dependency between LW instruction's destination register and one of the next instruction's source register
          // we need to insert a NOP. This means that pc shouldnt change for one clk cycle. check your waveform to make sure your pc doesnt change 
          if(uut.data_mem.ram[29]==32'hd15f1416) begin $display("DATA HAZARD RS DEPENDENCY    success!\n"); points= points+1; end else $display("DATA HAZARD RS DEPENDENCY  failed!\n");
          if(uut.data_mem.ram[30]==32'hb54bc032) begin $display("DATA HAZARD RT DEPENDENCY	success!\n"); points= points+1; end else $display("DATA HAZARD RT DEPENDENCY	failed!\n");
          
          // Control Hazard
          if(uut.data_mem.ram[31]==32'hc187a606) begin $display("CONTROL HAZARD BRANCH	success!\n"); points= points+1; end else $display("CONTROL HAZARD BRANCH	failed!\n");
          if(uut.data_mem.ram[32]==32'hb54bc031) begin $display("CONTROL HAZARD JUMP	success!\n"); points= points+1; end else $display("CONTROL HAZARD JUMP	failed!\n");
         
           $display("points: ", points);
           
      end  
endmodule