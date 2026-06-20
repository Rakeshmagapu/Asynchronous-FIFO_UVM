class wr_mon extends uvm_monitor;
	`uvm_component_utils(wr_mon)
	`newc
	uvm_analysis_port#(wr_tx) ap_port;
	wr_tx tx;
	virtual fifo_intf vif;
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ap_port=new("ap_port",this);
		if(!uvm_config_db#(virtual fifo_intf)::get(this," ","VIF",vif) )begin
			`uvm_error(get_full_name,"while retrieving config db error occoured")
		end	
	endfunction
	//driver non blocking
	//monitor blocking
	task run_phase(uvm_phase phase);
		forever begin	
	   		@(vif.wr_mon_cb) 
				if(vif.wr_mon_cb.wr_en==1) begin
				tx=new();
				tx.wr_en = vif.wr_mon_cb.wr_en ;
			    tx.wdata = vif.wr_mon_cb.wdata;
				tx.full = vif.wr_mon_cb.full;
				tx.overflow = vif.wr_mon_cb.overflow;
			//	`uvm_info(get_full_name,"-------------wr-mon--------",UVM_NONE);
			//	tx.print();
				ap_port.write(tx);
				end	
		end
   endtask			
endclass	

