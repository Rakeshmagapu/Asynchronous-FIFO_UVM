class base_rd_seq extends uvm_sequence;
	`uvm_object_utils(base_rd_seq)
	`newo
     
	 task body();

	 endtask
endclass	
class rd_seq extends uvm_sequence#(rd_tx);
	`uvm_object_utils(rd_seq)
	`newo
	 int count; 
     task pre_body();
	 	uvm_config_db#(int)::get(null,"","INT2",count);
	 endtask
	 task body();
	 	repeat(count) begin
	 		`uvm_do_with(req,{req.rd_en==1;})
			//req.print();
			//`uvm_info(get_full_name,"---in rd_seq--",UVM_NONE);
		end 
	endtask
endclass
	
