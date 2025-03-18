//object classs
class spr_sequence extends uvm_sequence #(spr_seq_item);

  `uvm_object_utils(spr_sequence);

  
  //standard constructor
  function new(string name="spr_sequence");
    super.new(name);
      `uvm_info("[spr_sequence]","constructor",UVM_MEDIUM)
  endfunction
  
    virtual task body();
      repeat(15) begin 
        req= spr_seq_item ::type_id::create("req");
      wait_for_grant();
        assert(req.randomize());
        send_request(req);
        wait_for_item_done();
        `uvm_info("sequence randomized data", $sformatf("we=%0d,rd=%0d din=%0d addr=%0d dout=%0d ",req.we,req.rd,req.din,req.addr,req.dout),UVM_MEDIUM) 
       set_response_queue_depth(20) ;
    end
  endtask
    
endclass   


//--------------------------------------------------

//write operation
class spr_write_sequence extends uvm_sequence #(spr_seq_item);
  
  `uvm_object_utils(spr_write_sequence);
  spr_seq_item item;
  
  function new(string name= "spr_write_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    $display("starting of uvm seq body...");
    
    repeat(8) begin
      item=spr_seq_item::type_id::create("item");
      
      start_item(item);
      assert(item.randomize() with {item.we==1;item.rd==0;});
             finish_item(item);
      set_response_queue_depth(15);
      
    end
  endtask
endclass

//------------------------------------------------
//read operation
class spr_read_sequence extends uvm_sequence #(spr_seq_item);
  
  `uvm_object_utils(spr_read_sequence);

  
  function new(string name= "spr_read_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    $display("starting of uvm seq body...");
    
    repeat(8) begin
      `uvm_do_with(req,{req.rd==1;req.we==0;})
      
      set_response_queue_depth(15);
      
    end
  endtask
endclass

//==============================================================================
//write then read sequence
  
class spr_wr_then_rd_sequence extends uvm_sequence #(spr_seq_item);
  
  `uvm_object_utils(spr_wr_then_rd_sequence);
  spr_write_sequence wr_seq;
  spr_read_sequence rd_seq;

  
  function new(string name= "spr_wr_then_rd_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_do(wr_seq)
    `uvm_do(rd_seq)

  endtask
endclass

//======================================================================
//write read back to back
class spr_write_read_sequence extends uvm_sequence #(spr_seq_item);
  
  `uvm_object_utils(spr_write_read_sequence);

  
  function new(string name= "spr_write_read_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(5) begin
      `uvm_do_with(req,{req.we==1;req.rd==0;})
      `uvm_do_with(req,{req.we==0;req.rd==1;})
      
      set_response_queue_error_report_disabled(1);
      
    end
  endtask
endclass
//===========================================================================
//write read parallel
class spr_wr_rd_parallel_seq extends uvm_sequence #(spr_seq_item);
  
  `uvm_object_utils(spr_wr_rd_parallel_seq);
  spr_write_sequence wr_seq;
   spr_read_sequence rd_seq;
  
  function new(string name= "spr_wr_rd_parallel_seq");
    super.new(name);
  endfunction
  
  virtual task body();
    
     req=spr_seq_item::type_id::create("req");
      start_item(req);
    assert(req.randomize() with {req.we==1;req.rd==0;});
      finish_item(req);
    
    repeat(8) begin
      req=spr_seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {req.we==1;req.rd==1;});
      finish_item(req);
      set_response_queue_depth(15);
      end
  endtask
endclass








  
