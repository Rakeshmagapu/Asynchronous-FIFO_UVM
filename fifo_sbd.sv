`uvm_analysis_imp_decl(_write_)
`uvm_analysis_imp_decl(_read_)

class fifo_sbd extends uvm_scoreboard;
	`uvm_component_utils(fifo_sbd)
	`newc
	uvm_analysis_imp_write_#(wr_tx,fifo_sbd) imp_write;
	uvm_analysis_imp_read_#(rd_tx,fifo_sbd) imp_read;
	
	wr_tx t1;
	rd_tx t2;
	bit [`WIDTH-1:0] sbd_wq[$];
	bit [`WIDTH-1:0] sbd_rq[$];
	bit [`WIDTH-1:0] expected_data;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		imp_write=new("imp_write",this);
		imp_read=new("imp_read",this);
	endfunction	
	
	virtual function void write_write_(wr_tx t);
		$cast(t1,t);
		sbd_wq.push_back(t1.wdata);
	endfunction	
	virtual function void write_read_(rd_tx t);
		$cast(t2,t);
		sbd_rq.push_back(t2.rdata);
		expected_data=sbd_wq.pop_front();
		if(expected_data==t2.rdata) fifo_common::match++;
		else begin
			fifo_common::mis_match++;
			`uvm_error(get_type_name,$sformatf("expected data=%h not matched with actual value=%h",expected_data,t2.rdata));
		end	
	endfunction	

endclass	
