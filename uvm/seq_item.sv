`include "uvm_macros.svh"
//object class
class spr_seq_item extends uvm_sequence_item;
  `uvm_object_utils(spr_seq_item);
  
  rand bit we,rd;
  rand bit [5:0] addr;
  rand bit [7:0] din;
       bit [7:0] dout;
  
  
  //standard constructor
  function new(string name="spr_seq_item");
    super.new(name);
    `uvm_info("[spr_seq_item]","constructor",UVM_MEDIUM)
  endfunction
  
 //constraint addr_c{addr inside {[1:15]};}
  
endclass
