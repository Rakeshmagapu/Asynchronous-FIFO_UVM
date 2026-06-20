class rd_drv extends uvm_driver#(rd_tx);
	`uvm_component_utils(rd_drv)
	`newc
	virtual fifo_intf vif;
    rd_tx tx;
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual fifo_intf)::get(this," ","VIF",vif) )begin
			`uvm_error(get_full_name,"while retrieving config db error occoured")
		end	
	endfunction

	task run_phase(uvm_phase phase);
		forever begin
			wait(!vif.res);
			seq_item_port.get_next_item(req);
			driver_rd_task(req);
			seq_item_port.item_done();
		end
	endtask
	task driver_rd_task(rd_tx tx);
		@(vif.rd_drv_cb) 	
	//	@(vif.rd_drv_cb) 	
			vif.rd_drv_cb.rd_en <= tx.rd_en;
			if(tx.rd_en==1) tx.rdata <= vif.rd_drv_cb.rdata;
			else vif.rd_drv_cb.rdata <=0;
			tx.empty <= vif.rd_drv_cb.empty;
			tx.underflow <= vif.rd_drv_cb.underflow;
		@(vif.rd_drv_cb)
			vif.rd_drv_cb.rd_en <=0;
     endtask	
endclass	

