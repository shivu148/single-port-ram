class spr_test extends uvm_test;
  `uvm_component_utils(spr_test) 
  
  spr_environment env;
  //spr_sequence seq;
  
  virtual spr_if intf;
  //standard constructor
  function new(string name ="spr_test", uvm_component parent);
    super.new(name, parent);
    `uvm_info("spr_test", "constructor", UVM_MEDIUM)
  endfunction
  
  // build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env=spr_environment::type_id::create("env",this);
   // seq=spr_sequence::type_id::create("seq");
    
    uvm_config_db#(virtual spr_if)::set(this, "env", "vif", intf);
    
    if(! uvm_config_db#(virtual spr_if)::get(this, "", "vif", intf)) 
      begin
        `uvm_error("build_phase","Test virtual interface failed")
      end
  endfunction

  
  virtual function void end_of_elaobration();
    print();
  endfunction

  //run phase
  task run_phase(uvm_phase phase);
    spr_sequence seq;
    seq = spr_sequence::type_id::create("seq");
    
    `uvm_info("spr_test", "run_phase", UVM_MEDIUM)
    
    phase.raise_objection(this,"starting main phase"); 
    $display("%t starting sequence spr_seq run_phase",$time);
    seq.start(env.age.seqr); 
    phase.drop_objection(this,"finished spr_seq in main_phase"); 
  endtask 
  
endclass
///////////////////////////////////////////////////////////////////////////////
//write complete then read complete spr_wr_then_rd_sequence

class spr_wr_then_rd_test extends spr_test;

  `uvm_component_utils(spr_wr_then_rd_test)
  
  // sequence instance 
  spr_wr_then_rd_sequence seq;

  // constructor
  function new(string name = "spr_wr_rd_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  // build_phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create the sequence
    seq = spr_wr_then_rd_sequence::type_id::create("seq");
  endfunction
  
  // run_phase - starting the test
  task run_phase(uvm_phase phase);
    
    phase.raise_objection(this);
    seq.start(env.age.seqr);
    phase.drop_objection(this);
    
    //set a drain-time for the environment if desired
    phase.phase_done.set_drain_time(this, 50);
  endtask
  
endclass
/////////////////////////////////////////////

//-------------------------------------------------------------------------
//write complete parall wrte read complete spr_parall_rd_sequence

class spr_wr_rd_parll_test extends spr_test;

  `uvm_component_utils(spr_wr_rd_parll_test)
  
  // sequence instance 
	spr_wr_rd_parallel_seq seq;
  // constructor
  function new(string name = "spr_wr_rd_parll_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  // build_phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create the sequence    
        seq = spr_wr_rd_parallel_seq::type_id::create("seq");

  endfunction
  
  // run_phase - starting the test
  task run_phase(uvm_phase phase);
    
    phase.raise_objection(this);
    seq.start(env.age.seqr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this, 50);

  endtask 
  
endclass
