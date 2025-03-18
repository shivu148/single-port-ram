class spr_scoreboard extends uvm_scoreboard;
  
  `uvm_component_utils(spr_scoreboard)
  
  uvm_analysis_imp#(spr_seq_item,spr_scoreboard) scb_port;
  
  spr_seq_item que[$];
  
  spr_seq_item trans;
  
  bit [7:0]mem[$];
  bit [7:0] tx_data;
  bit read_dealy_clk;
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    scb_port=new("scb_port",this);
  endfunction
  
  function void write(spr_seq_item transaction);
    que.push_back(transaction);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    forever begin
      
      wait(que.size()>0);
      trans=que.pop_front();
      
      if(trans.we==1)begin
        mem.push_back(trans.din);
      end
      
      if(trans.rd==1 || (read_dealy_clk !=0))
        begin
          
          if(read_dealy_clk==0)read_dealy_clk=1;
          
          	else begin
              if(trans.rd==0) read_dealy_clk=0;
              
              if(mem.size>0)
                begin
                  tx_data=mem.pop_front();
                  if(trans.dout==tx_data)
                    begin
                      `uvm_info("scoreboard",$sformatf("----:: EXPECTED MATCH::----"),UVM_MEDIUM)
                      `uvm_info("scoreboard",$sformatf("Exp data: %0d, Rec data=%0d",tx_data,trans.dout),UVM_MEDIUM)
                      `uvm_info("scoreboard",$sformatf("-------------------------"),UVM_MEDIUM)
                    end
                  else
                    begin
                      `uvm_info("scoreboard",$sformatf("----:: FAILED MATCH::----"),UVM_MEDIUM)
                      `uvm_info("scoreboard",$sformatf("Exp data: %0d, Rec data=%0d",tx_data,trans.dout),UVM_MEDIUM)
                      `uvm_info("scoreboard",$sformatf("-------------------------"),UVM_MEDIUM)
                    end
                end
            end
        end
      
      else
        read_dealy_clk=0;
    end
                      
  endtask
  
endclass


