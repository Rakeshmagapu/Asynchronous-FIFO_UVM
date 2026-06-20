`define WIDTH 8
`define FIFO_SIZE 16
`define PTR_WIDTH $clog2(`FIFO_SIZE)

`define newc function new(string name="",uvm_component parent=null);\
super.new(name,parent);\
endfunction

`define newo function new(string name="");\
super.new(name);\
endfunction
class fifo_common;
	static int match;
	static int mis_match;
endclass	
		
		
		
