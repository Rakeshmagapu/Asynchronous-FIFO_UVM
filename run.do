#compilation 
vlog top.sv +incdir+C:/questasim64_10.7c/uvm-1.2/uvm-1.2/uvm-1.2/src
#elaboration
vsim -novopt -suppress 12110 top -sv_seed 1245\
-sv_lib C:/questasim64_10.7c/uvm-1.2/win64/uvm_dpi
#add wave
add wave -r sim:/top/pif/*
#simulation
run -all
