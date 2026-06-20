class env extends uvm_env;
	`uvm_component_utils(env)
	`newc
	
	wr_agent wr_agent_h;
	rd_agent rd_agent_h;
	fifo_sbd fifo_sbd_h;
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		wr_agent_h=wr_agent::type_id::create("wr_agent_h",this);
		rd_agent_h=rd_agent::type_id::create("rd_agent_h",this);
		fifo_sbd_h=fifo_sbd::type_id::create("fifo_sbd_h",this);
	endfunction
	function void connect_phase(uvm_phase phase);
		wr_agent_h.wr_mon_h.ap_port.connect(fifo_sbd_h.imp_write);
		rd_agent_h.rd_mon_h.ap_port.connect(fifo_sbd_h.imp_read);
	endfunction	
endclass	


