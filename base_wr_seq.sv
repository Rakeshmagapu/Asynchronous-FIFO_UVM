class base_wr_seq extends uvm_sequence;
	`uvm_object_utils(base_wr_seq)
	`newo
     
	 task body();

	 endtask
endclass	
class wr_full_seq extends uvm_sequence#(wr_tx);
	`uvm_object_utils(wr_full_seq)
	`newo 
	 task body();
	 	repeat(`FIFO_SIZE) begin
	 		`uvm_do_with(req,{req.wr_en==1;})
			// req.print();
			//`uvm_info(get_full_name,"---in wr_seq--",UVM_NONE);
		end 
	endtask
endclass
class wr_overflow_seq extends uvm_sequence#(wr_tx);
	`uvm_object_utils(wr_overflow_seq)
	`newo
	 task body();
	 	repeat(`FIFO_SIZE+1) begin
	 		`uvm_do_with(req,{req.wr_en==1;})
			// req.print();
			//`uvm_info(get_full_name,"---in wr_seq--",UVM_NONE);
		end 
	endtask
endclass

class wr_seq extends uvm_sequence#(wr_tx);
	`uvm_object_utils(wr_seq)
	`newo
	int count;
	
	task pre_body();
		uvm_config_db#(int)::get(null,"","INT1",count);
	endtask
	
	task body();
			repeat(count) begin
	 		`uvm_do_with(req,{req.wr_en==1;})	
			// req.print();
			//`uvm_info(get_full_name,"********in wr_seq********",UVM_NONE);
			end 
	endtask
endclass	
	

