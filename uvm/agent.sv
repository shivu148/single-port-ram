class spr_agent extends uvm_agent;
  
  spr_sequencer seqr;
  spr_driver drv;
  spr_monitor mon;
  
  `uvm_component_utils_begin(spr_agent)
  `uvm_field_object(seqr, UVM_ALL_ON)
  `uvm_field_object(drv, UVM_ALL_ON)
  `uvm_field_object(mon, UVM_ALL_ON)
  `uvm_component_utils_end
 
  
  //standard constructor
  function new(string name ="spr_agent", uvm_component parent);
    super.new(name, parent);
    `uvm_info("spr_agent", "constructor", UVM_MEDIUM)
  endfunction
  
   function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     
     mon=spr_monitor::type_id::create("mon",this);
     seqr=spr_sequencer::type_id::create("seqr",this);
     drv=spr_driver::type_id::create("drv",this);
     
     `uvm_info("spr_agent", "build_phase", UVM_MEDIUM)
    
   endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("spr_agent", "connect_phase", UVM_MEDIUM)
    
      drv.seq_item_port.connect(seqr.seq_item_export);
    `uvm_info("spr_agent", "connect_phase, Connected sequencer to driver",UVM_MEDIUM)
    
  endfunction
  
endclass
