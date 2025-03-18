//component class
`define MON_IF intf.MONITOR.monitor_cb
class spr_monitor extends uvm_monitor;
  `uvm_component_utils(spr_monitor)
  
  uvm_analysis_port  #(spr_seq_item)ap;
  
  virtual spr_if intf;
   spr_seq_item trans;
  //spr_seq_item tr;
  
  //standard constructor
  function new(string name ="spr_monitor", uvm_component parent);
    super.new(name, parent);
    ap=new("ap",this);
    `uvm_info("spr_monitor", "constructor", UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   // tr = spr_seq_item::type_id::create("tr");
    `uvm_info("spr_monitor", "build_phase", UVM_MEDIUM)
    if(!uvm_config_db#(virtual spr_if)::get(this, "", "vif", intf))
      `uvm_fatal("[spr_monitor]","virtual interface get failed from config db");
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    forever begin
      
     
      trans=spr_seq_item::type_id::create("trans");
   //   ap.write(trans);
      	  trans.we=`MON_IF.we;
          trans.din=`MON_IF.din;
          trans.addr=`MON_IF.addr;
          
          trans.rd=`MON_IF.rd;
       @(posedge intf.MONITOR.clk);    
          trans.dout=`MON_IF.dout;
      `uvm_info("monitor",$sformatf("read op:we=%0d,rd=%0d,addr=%0d,data_in=%0d,data_out=%0d",trans.we,trans.rd,trans.addr,trans.din,trans.dout),UVM_MEDIUM)
        
      @(posedge intf.MONITOR.clk);
        
      ap.write(trans);
    end  
  endtask
endclass

  
  
