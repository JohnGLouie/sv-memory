# ModelSim 10.4b bug: need to delete library if it already exists because vlib work will
# seg fault otherwise.
if {[file isdirectory work]} {
    vdel -all -lib work
}

# Create library
vlib work

# Compile .sv files.
vlog -work work "../sync_fifo.sv"
vlog -work work "sync_fifo_tb.sv"
