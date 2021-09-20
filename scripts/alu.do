onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /alu_tb/CLK
add wave -noupdate /alu_tb/alureg/neg
add wave -noupdate /alu_tb/alureg/overflow
add wave -noupdate /alu_tb/alureg/zero
add wave -noupdate /alu_tb/alureg/alu_op
add wave -noupdate /alu_tb/alureg/port_A
add wave -noupdate /alu_tb/alureg/port_B
add wave -noupdate /alu_tb/alureg/outport
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {30 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1 us}
