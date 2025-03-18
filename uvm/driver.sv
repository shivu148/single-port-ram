//component class
`define DRIV_IF intf.DRIVER.driver_cb
class spr_driver extends uvm_driver #(spr_seq_item);
  `uvm_component_utils(spr_driver)
  
  virtual spr_if intf;
  spr_seq_item tr;
  
  //standard constructor
  function new(string name="spr_driver",uvm_component parent);
    super.new(name,parent);
    `uvm_info("spr_driver","constructor",UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("spr_driver","build_phase",UVM_MEDIUM)
   
   // tr = spr_seq_item::type_id::create("tr");
    if(!uvm_config_db#(virtual spr_if)::get(this, "", "vif", intf))
      `uvm_fatal("spr_driver","virtual interface get failed from config db");
    
  endfunction
 
  //run phase
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    $display("Starting UVM driver RUN phase---");
    
    forever begin
      tr=spr_seq_item::type_id::create("tr");
      seq_item_port.get_next_item(tr);
      
      @(posedge intf.DRIVER.clk);
      
      if(tr.we)begin
        `DRIV_IF.we<=tr.we;
        `DRIV_IF.rd<=tr.rd;
        `DRIV_IF.addr<=tr.addr;
        `DRIV_IF.din<=tr.din;
        `uvm_info("driver",$sformatf("write data:we=%0d,rd=%0d,addr=%0d,din=%0d dout=%0d",tr.we,tr.rd,tr.addr,tr.din,tr.dout),UVM_MEDIUM)
      end
      
      else if(tr.rd) begin
        `DRIV_IF.we<=tr.we;
        `DRIV_IF.rd<=tr.rd;
        `DRIV_IF.addr<=tr.addr;
        
        `uvm_info("driver",$sformatf("read data:we=%0d,rd=%0d,addr=%0d,din=%0d dout=%0d",tr.we,tr.rd,tr.addr,tr.din,tr.dout),UVM_MEDIUM)
      end
      
      seq_item_port.item_done(tr);
    end
  endtask
endclass

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
 
