class wr_cov extends uvm_subscriber#(wr_tx);
	`uvm_component_utils(wr_cov)
	 wr_tx tx;
	covergroup cg;
		WR_EN:coverpoint tx.wr_en{
		bins write ={1'b1};
		}
	endgroup

	function new(string name="",uvm_component parent=null);
		super.new(name,parent);
		cg=new();
	endfunction

	virtual function void write(wr_tx t);
		$cast(tx,t);
		cg.sample();
	endfunction
endclass	
