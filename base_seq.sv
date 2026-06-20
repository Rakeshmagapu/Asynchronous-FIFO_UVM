class base_seq extends uvm_sequence;
	`uvm_object_utils(base_seq)
	`newo
     
	 task body();

	 endtask
endclass	
class wr_seq extends uvm_sequence#(wr_tx);
	`uvm_object_utils(wr_seq)
	`newo
     
	 task body();
	 //full condition
	 /*	repeat(`FIFO_SIZE) begin
	 		`uvm_do_with(req,{req.wr_en==1;})
			// req.print();
			//`uvm_info(get_full_name,"---in wr_seq--",UVM_NONE);
		end */
	 //overflow condition
	 	repeat(5) begin
	 		`uvm_do_with(req,{req.wr_en==1;})
			// req.print();
			//`uvm_info(get_full_name,"---in wr_seq--",UVM_NONE);
		end 

	 endtask
endclass
class rd_seq extends uvm_sequence#(rd_tx);
	`uvm_object_utils(rd_seq)
	`newo
	
	//empty
/*	task body();
			repeat(`FIFO_SIZE) begin
	 		`uvm_do_with(req,{req.rd_en==1;})
			 req.print();
			`uvm_info(get_full_name,"********in rd_seq********",UVM_NONE);
		end */

	 //underflow 
	 task body();
			repeat(5) begin
	 		`uvm_do_with(req,{req.rd_en==1;})
		//	 req.print();
			`uvm_info(get_full_name,"********in rd_seq********",UVM_NONE);
		end

	 endtask
endclass	
	
