onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dcache_tb/CLK
add wave -noupdate /dcache_tb/nRST
add wave -noupdate -expand -group ff /dcache_tb/DUT/left_tag
add wave -noupdate -expand -group ff /dcache_tb/DUT/right_tag
add wave -noupdate -expand -group ff /dcache_tb/DUT/left_dirty
add wave -noupdate -expand -group ff /dcache_tb/DUT/right_dirty
add wave -noupdate -expand -group ff /dcache_tb/DUT/left_valid
add wave -noupdate -expand -group ff /dcache_tb/DUT/right_valid
add wave -noupdate -expand -group ff /dcache_tb/DUT/left_data0
add wave -noupdate -expand -group ff /dcache_tb/DUT/left_data1
add wave -noupdate -expand -group ff /dcache_tb/DUT/right_data0
add wave -noupdate -expand -group ff /dcache_tb/DUT/right_data1
add wave -noupdate -expand -group ff /dcache_tb/DUT/dcache_addr
add wave -noupdate -expand -group ff /dcache_tb/DUT/frame
add wave -noupdate -expand -group ff /dcache_tb/DUT/state
add wave -noupdate -expand -group ff /dcache_tb/DUT/next_state
add wave -noupdate -expand -group ff /dcache_tb/DUT/recent
add wave -noupdate -expand -group ff /dcache_tb/DUT/next_recent
add wave -noupdate -expand -group ff /dcache_tb/DUT/hit_counter
add wave -noupdate -expand -group ff /dcache_tb/DUT/next_hit_counter
add wave -noupdate -expand -group ff /dcache_tb/DUT/flush_count
add wave -noupdate -expand -group ff /dcache_tb/DUT/next_flush_count
add wave -noupdate -group cif /dcache_tb/DUT/cif/iwait
add wave -noupdate -group cif /dcache_tb/DUT/cif/dwait
add wave -noupdate -group cif /dcache_tb/DUT/cif/iREN
add wave -noupdate -group cif /dcache_tb/DUT/cif/dREN
add wave -noupdate -group cif /dcache_tb/DUT/cif/dWEN
add wave -noupdate -group cif /dcache_tb/DUT/cif/iload
add wave -noupdate -group cif /dcache_tb/DUT/cif/dload
add wave -noupdate -group cif /dcache_tb/DUT/cif/dstore
add wave -noupdate -group cif /dcache_tb/DUT/cif/iaddr
add wave -noupdate -group cif /dcache_tb/DUT/cif/daddr
add wave -noupdate -group cif /dcache_tb/DUT/cif/ccwait
add wave -noupdate -group cif /dcache_tb/DUT/cif/ccinv
add wave -noupdate -group cif /dcache_tb/DUT/cif/ccwrite
add wave -noupdate -group cif /dcache_tb/DUT/cif/cctrans
add wave -noupdate -group cif /dcache_tb/DUT/cif/ccsnoopaddr
add wave -noupdate -group dcif /dcache_tb/DUT/dpif/halt
add wave -noupdate -group dcif /dcache_tb/DUT/dpif/ihit
add wave -noupdate -group dcif /dcache_tb/DUT/dpif/imemREN
add wave -noupdate -group dcif /dcache_tb/DUT/dpif/imemload
add wave -noupdate -group dcif /dcache_tb/DUT/dpif/imemaddr
add wave -noupdate -group dcif /dcache_tb/DUT/dpif/dhit
add wave -noupdate -group dcif /dcache_tb/DUT/dpif/datomic
add wave -noupdate -group dcif /dcache_tb/DUT/dpif/dmemREN
add wave -noupdate -group dcif /dcache_tb/DUT/dpif/dmemWEN
add wave -noupdate -group dcif /dcache_tb/DUT/dpif/flushed
add wave -noupdate -group dcif /dcache_tb/DUT/dpif/dmemload
add wave -noupdate -group dcif /dcache_tb/DUT/dpif/dmemstore
add wave -noupdate -group dcif /dcache_tb/DUT/dpif/dmemaddr
add wave -noupdate /dcache_tb/PROG/test_num
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
WaveRestoreZoom {0 ns} {929 ns}
