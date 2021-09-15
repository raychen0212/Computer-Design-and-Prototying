onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /request_unit_tb/CLK
add wave -noupdate /request_unit_tb/nRST
add wave -noupdate /request_unit_tb/DUT/ruif/ihit
add wave -noupdate /request_unit_tb/DUT/ruif/dhit
add wave -noupdate /request_unit_tb/DUT/ruif/dREN
add wave -noupdate /request_unit_tb/DUT/ruif/dWEN
add wave -noupdate /request_unit_tb/DUT/ruif/dmemREN
add wave -noupdate /request_unit_tb/DUT/ruif/dmemWEN
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {181 ns} 0}
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
