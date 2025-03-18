class spr_environment extends uvm_env;
  `uvm_component_utils(spr_environment) 
  
  spr_scoreboard sco;
  spr_agent age;
  
  //standard constructor
  function new(string name ="spr_environment", uvm_component parent);
    super.new(name, parent);
    `uvm_info("spr_environment", "constructor", UVM_MEDIUM)
  endfunction
  
  // build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   
    age=spr_agent::type_id::create("age",this);
    sco=spr_scoreboard::type_id::create("sco",this);
  endfunction
  
   // connect phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("spr_environment","connect phase",UVM_MEDIUM)
    //connecting monitor-scoreboard using TLM analysis ports
    age.mon.ap.connect(sco.scb_port);
    `uvm_info("spr_environment", "connect_phase, Connected monitor to scoreboard",UVM_MEDIUM)
  endfunction
  
endclass
