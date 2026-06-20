interface fifo_intf(input bit wr_clk,rd_clk,res);
	bit wr_en,rd_en;
	bit empty,underflow,overflow,full;
	bit [`WIDTH-1:0] wdata,rdata;

	clocking wr_drv_cb@(posedge wr_clk);
		input full,overflow;
		output wr_en,wdata;
	endclocking
	clocking rd_drv_cb@(posedge rd_clk);
		input empty,underflow;
		output rd_en,rdata;
	endclocking

	clocking wr_mon_cb@(posedge wr_clk);
		input full,overflow;
		input wr_en,wdata;
	endclocking
	clocking rd_mon_cb@(posedge rd_clk);
		default input#0;
		input rdata,empty,underflow;
		input rd_en;
	endclocking


endinterface
	
	
