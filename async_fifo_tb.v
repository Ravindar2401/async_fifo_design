
`timescale 1ns/1ps
module async_fifo_tb;

parameter DSIZE=8;
parameter ASIZE=4;

reg wclk,rclk,wrst_n,rrst_n,winc,rinc;
reg [DSIZE-1:0] wdata;
wire [DSIZE-1:0] rdata;
wire wfull,rempty;

integer i;
integer errors;
reg [7:0] exp_mem[0:255];
integer wr_idx,rd_idx;

async_fifo #(DSIZE,ASIZE) dut(
 .wclk(wclk),.wrst_n(wrst_n),.winc(winc),.wdata(wdata),.wfull(wfull),
 .rclk(rclk),.rrst_n(rrst_n),.rinc(rinc),.rdata(rdata),.rempty(rempty));

always #5 wclk=~wclk;
always #7 rclk=~rclk;

task write_byte(input [7:0] d);
begin
 @(negedge wclk);
 while(wfull) @(negedge wclk);
 wdata=d; winc=1;
 @(posedge wclk);
 exp_mem[wr_idx]=d; wr_idx=wr_idx+1;
 @(negedge wclk);
 winc=0;
end
endtask

task read_byte;
reg [7:0] exp;
begin
 @(negedge rclk);
 while(rempty) @(negedge rclk);
 rinc=1;
 @(posedge rclk);
 #1;
 exp=exp_mem[rd_idx];
 if(rdata!==exp) begin
   $display("FAIL exp=%h got=%h time=%0t",exp,rdata,$time);
   errors=errors+1;
 end else
   $display("PASS data=%h",rdata);
 rd_idx=rd_idx+1;
 @(negedge rclk);
 rinc=0;
end
endtask

initial begin
 wclk=0; rclk=0; wrst_n=0; rrst_n=0;
 winc=0; rinc=0; wdata=0;
 errors=0; wr_idx=0; rd_idx=0;
 #20;
 wrst_n=1; rrst_n=1;

 if(rempty!==1) begin
   $display("RESET TEST FAIL");
   errors=errors+1;
 end

 for(i=0;i<10;i=i+1) write_byte(i);
 repeat(4) @(posedge rclk);
 for(i=0;i<10;i=i+1) read_byte();

 // fill fifo
 for(i=0;i<16;i=i+1) write_byte(i+8'h20);
 repeat(2) @(posedge wclk);
 if(!wfull) begin
   $display("FULL FLAG FAIL");
   errors=errors+1;
 end

 // drain fifo
 repeat(4) @(posedge rclk);
 for(i=0;i<16;i=i+1) read_byte();

 repeat(2) @(posedge rclk);
 if(!rempty) begin
   $display("EMPTY FLAG FAIL");
   errors=errors+1;
 end

 if(errors==0)
   $display("\n******** ALL TESTS PASSED ********");
 else
   $display("\n******** TEST FAILED : %0d ERRORS ********",errors);

 #50 $finish;
end

initial begin
 $dumpfile("async_fifo_tb.vcd");
 $dumpvars(0,async_fifo_tb);
end

endmodule
