class wr_drv extends uvm_driver#(wr_tx);
	`uvm_component_utils(wr_drv)
	`newc
	wr_tx tx;
	virtual fifo_intf vif;
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
			driver_wr_task(req);
		//	 req.print();
		//	`uvm_info(get_full_name,"---in wr_drv--",UVM_NONE);
			seq_item_port.item_done();
		end
	endtask
	task driver_wr_task(wr_tx tx);
		@(vif.wr_drv_cb) 
			vif.wr_drv_cb.wr_en <= tx.wr_en;
			if(tx.wr_en==1) vif.wr_drv_cb.wdata <= tx.wdata;
			else vif.wr_drv_cb.wdata <=0;
			tx.full <= vif.wr_drv_cb.full;
			tx.overflow <= vif.wr_drv_cb.overflow;
		@(vif.wr_drv_cb)
			vif.wr_drv_cb.wr_en <=0;
			vif.wr_drv_cb.wdata <=0;
     endtask			
endclass	

