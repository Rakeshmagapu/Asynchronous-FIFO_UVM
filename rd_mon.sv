class rd_mon extends uvm_monitor;
	`uvm_component_utils(rd_mon)
	`newc
	uvm_analysis_port#(rd_tx) ap_port;
	rd_tx tx;
	virtual fifo_intf vif;
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ap_port=new("ap_port",this);
		if(!uvm_config_db#(virtual fifo_intf)::get(this," ","VIF",vif) )begin
			`uvm_error(get_full_name,"while retrieving config db error occoured")
		end	
	endfunction

	task run_phase(uvm_phase phase);
		forever begin	
	   		@(vif.rd_mon_cb) 
				if(vif.rd_mon_cb.rd_en==1) begin
				tx=new();
				tx.rd_en = vif.rd_mon_cb.rd_en ;
			    tx.rdata = vif.rd_mon_cb.rdata;
				tx.empty = vif.rd_mon_cb.empty;
				tx.underflow = vif.rd_mon_cb.underflow;
			//	`uvm_info(get_full_name,"-------------rd-mon--------",UVM_NONE);
			//	tx.print();
				ap_port.write(tx);
				end
		end	 
    endtask			
endclass	

