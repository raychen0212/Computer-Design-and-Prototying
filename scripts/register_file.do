onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /register_file_tb/CLK
add wave -noupdate /register_file_tb/nRST
add wave -noupdate -expand /register_file_tb/DUT/reg_map
add wave -noupdate /register_file_tb/PROG/tbif/WEN
add wave -noupdate /register_file_tb/PROG/tbif/wsel
add wave -noupdate /register_file_tb/PROG/tbif/rsel1
add wave -noupdate /register_file_tb/PROG/tbif/rsel2
add wave -noupdate /register_file_tb/PROG/tbif/wdat
add wave -noupdate /register_file_tb/PROG/tbif/rdat1
add wave -noupdate /register_file_tb/PROG/tbif/rdat2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {14 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 90
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
WaveRestoreZoom {8 ns} {32 ns}
