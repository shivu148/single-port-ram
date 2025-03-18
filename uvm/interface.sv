interface spr_if(input logic clk,rst);

  logic [7:0]din;

  logic [7:0]dout;

  logic we,rd;

  logic [5:0]addr;


  clocking driver_cb @(posedge clk);

  default input #1 output #1;

    output din;

    output we,rd;
    output addr;
    input dout;

  endclocking

  

  clocking monitor_cb @(posedge clk);

   default input #1 output #1;

    input din;

    input we,rd;

    input addr;

    input dout;

  endclocking  

  

  modport DRIVER(clocking driver_cb,input clk,rst);

  modport MONITOR(clocking monitor_cb,input clk,rst);

  

endinterface
