class rd_cov extends uvm_subscriber#(rd_tx);
	`uvm_component_utils(rd_cov)
	 rd_tx tx;
	covergroup cg;
		RD_EN:coverpoint tx.rd_en{
		bins read ={1'b1};
		}
	endgroup

	function new(string name="",uvm_component parent=null);
		super.new(name,parent);
		cg=new();
	endfunction

	virtual function void write(rd_tx t);
		$cast(tx,t);
		cg.sample();
	endfunction
endclass	
  
