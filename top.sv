`include "list.svh"

module top;
	bit wr_clk,rd_clk,res;

	fifo_intf pif(wr_clk,rd_clk,res);
	
	async dut(.wr_clk(pif.wr_clk),
			 . rd_clk(pif.rd_clk),
			 . res(pif.res),
			 . wr_en(pif.wr_en),
			 . wdata(pif.wdata),
			 . full(pif.full),
			 . overflow(pif.overflow),
			 . rd_en(pif.rd_en),
			 . rdata(pif.rdata),
			.  empty(pif.empty),
			 . underflow(pif.underflow));
	always #5 wr_clk=~wr_clk;
	always #7 rd_clk=~rd_clk;

    initial begin
		wr_clk=0;
		rd_clk=0;
		res=1;
		repeat(2) @(posedge wr_clk)
		res=0;
	end

	initial begin
      //run_test("full_test");
	 // run_test("overflow_test");
	  //run_test("nwr_nrd_test");
	  run_test("concurrent_test");
	end

	initial begin
		uvm_config_db#(virtual fifo_intf)::set(null,"*","VIF",pif);
	end	
endmodule
