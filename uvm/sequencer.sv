//component class
class spr_sequencer extends uvm_sequencer #(spr_seq_item);
  `uvm_component_utils(spr_sequencer);
  
  //standard constructor
  function new(string name="spr_sequencer",uvm_component parent);
    super.new(name,parent);
    `uvm_info("spr_sequencer","constructor",UVM_MEDIUM)
  endfunction
  
endclass
  
