class base_test extends uvm_test;
	`uvm_component_utils(base_test)
	`newc
	
	env env_h;
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env_h=env::type_id::create("env_h",this);
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology();	
	endfunction
	
	function void extract_phase(uvm_phase phase);
		
	endfunction

	function void check_phase(uvm_phase phase);
		if(fifo_common::match!=0 && fifo_common::mis_match==0) begin
	`uvm_info(get_type_name,$sformatf("match_count =%0d,--------TEST_PASSED",fifo_common::match),UVM_NONE);
		end
		else begin
		if(fifo_common::match!=0 && fifo_common::mis_match==0) begin
		`uvm_info(get_type_name,$sformatf("mis_match_count =%0d,--------TEST_FAILED",fifo_common::mis_match),UVM_NONE);
		end
		end	

	endfunction

	function void report_phase(uvm_phase phase);
	endfunction

endclass
class full_test extends base_test;
	`uvm_component_utils(full_test)
	`newc
	
	task run_phase(uvm_phase phase);
		wr_full_seq wr_full_seq_h;
		wr_full_seq_h=wr_full_seq::type_id::create("wr_full_seq_h");
		phase.raise_objection(this);
		wr_full_seq_h.start(env_h.wr_agent_h.wr_sqr_h);
		phase.phase_done.set_drain_time(this,100);
		phase.drop_objection(this);
	endtask
endclass
class overflow_test extends base_test;
	`uvm_component_utils(overflow_test)
	`newc
	
	task run_phase(uvm_phase phase);
		wr_overflow_seq wr_overflow_seq_h;
		wr_overflow_seq_h=wr_overflow_seq::type_id::create("wr_overflow_seq_h");
		phase.raise_objection(this);
		wr_overflow_seq_h.start(env_h.wr_agent_h.wr_sqr_h);
		phase.phase_done.set_drain_time(this,100);
		phase.drop_objection(this);
	endtask
endclass

//empty and underflow 
class nwr_nrd_test extends base_test;
	`uvm_component_utils(nwr_nrd_test)
	`newc

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db#(int)::set(null,"*","INT1",16);
		uvm_config_db#(int)::set(null,"*","INT2",16);
	endfunction
	
	task run_phase(uvm_phase phase);
		wr_seq wr_seq_h;
		rd_seq rd_seq_h;
		wr_seq_h=wr_seq::type_id::create("wr_seq_h");
		rd_seq_h=rd_seq::type_id::create("rd_seq_h");
		phase.raise_objection(this);
		wr_seq_h.start(env_h.wr_agent_h.wr_sqr_h);
		rd_seq_h.start(env_h.rd_agent_h.rd_sqr_h);
		phase.phase_done.set_drain_time(this,100);
		phase.drop_objection(this);
	endtask
endclass

class concurrent_test extends base_test;
	`uvm_component_utils(concurrent_test)
	`newc

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db#(int)::set(null,"*","INT1",2);
		uvm_config_db#(int)::set(null,"*","INT2",2);
	endfunction
	
	task run_phase(uvm_phase phase);
		wr_seq wr_seq_h;
		rd_seq rd_seq_h;
		wr_seq_h=wr_seq::type_id::create("wr_seq_h");
		rd_seq_h=rd_seq::type_id::create("rd_seq_h");
		phase.raise_objection(this);
		fork
			wr_seq_h.start(env_h.wr_agent_h.wr_sqr_h);
			#3 rd_seq_h.start(env_h.rd_agent_h.rd_sqr_h);
		join	
		phase.phase_done.set_drain_time(this,200);
		phase.drop_objection(this);
	endtask
endclass




