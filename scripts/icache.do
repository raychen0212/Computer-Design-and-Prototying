onerror {resume}
quietly virtual function -install /icache_tb/cif -env /icache_tb/DUT { &{/icache_tb/cif/iwait, /icache_tb/cif/iREN, /icache_tb/cif/iload, /icache_tb/cif/iaddr }} control_if
quietly WaveActivateNextPane {} 0
add wave -noupdate /icache_tb/CLK
add wave -noupdate /icache_tb/nRST
add wave -noupdate /icache_tb/DUT/hit
add wave -noupdate /icache_tb/DUT/miss
add wave -noupdate /icache_tb/DUT/icache_addr
add wave -noupdate /icache_tb/DUT/frame
add wave -noupdate -group {datapath if} /icache_tb/dpif/ihit
add wave -noupdate -group {datapath if} /icache_tb/dpif/imemREN
add wave -noupdate -group {datapath if} /icache_tb/dpif/imemload
add wave -noupdate -group {datapath if} /icache_tb/dpif/imemaddr
add wave -noupdate -group {Control if} /icache_tb/cif/iwait
add wave -noupdate -group {Control if} /icache_tb/cif/iREN
add wave -noupdate -group {Control if} /icache_tb/cif/iload
add wave -noupdate -group {Control if} /icache_tb/cif/iaddr
add wave -noupdate /icache_tb/DUT/state
add wave -noupdate /icache_tb/DUT/nxt_state
add wave -noupdate /icache_tb/PROG/test_num
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {0 ns} {3620 ns}
