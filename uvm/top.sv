`include "uvm_macros.svh" // contains all uvm macros
import uvm_pkg::*; // contains all uvm base classes

//include classes in order
`include "interface.sv"
`include "seq_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "test.sv"
`include "wr_then_rd_test.sv"
`include "wr_rd_parallel.sv"

module tb;
  
  bit clk;
  bit rst;
  
  initial begin
    clk=0;
    forever #5 clk=~clk;
  end
  
  initial begin
    rst=1;
    #2 rst=0;
  end
  
  spr_if intf(clk,rst);
  
  spr dut(.clk(intf.clk),.rst(intf.rst),.we(intf.we),.rd(intf.rd),.addr(intf.addr),.din(intf.din),.dout(intf.dout));

  
//Confg Db  
  initial begin
    uvm_config_db #(virtual spr_if)::set(null,"*","vif",intf);
  end

  initial begin
    run_test("spr_wr_then_rd_test");
   // run_test("spr_wr_rd_parll_test");
  end
  
  initial begin
  	 $dumpfile("dump.vcd");
	 $dumpvars;
   // #300 $finish;
 end
 
endmodule

