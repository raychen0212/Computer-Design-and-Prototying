onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dcache_tb/CLK
add wave -noupdate /dcache_tb/nRST
add wave -noupdate -group dpif0 /dcache_tb/PROG/dpif0/halt
add wave -noupdate -group dpif0 /dcache_tb/PROG/dpif0/ihit
add wave -noupdate -group dpif0 /dcache_tb/PROG/dpif0/imemREN
add wave -noupdate -group dpif0 /dcache_tb/PROG/dpif0/imemload
add wave -noupdate -group dpif0 /dcache_tb/PROG/dpif0/imemaddr
add wave -noupdate -group dpif0 /dcache_tb/PROG/dpif0/dhit
add wave -noupdate -group dpif0 /dcache_tb/PROG/dpif0/datomic
add wave -noupdate -group dpif0 /dcache_tb/PROG/dpif0/dmemREN
add wave -noupdate -group dpif0 /dcache_tb/PROG/dpif0/dmemWEN
add wave -noupdate -group dpif0 /dcache_tb/PROG/dpif0/flushed
add wave -noupdate -group dpif0 /dcache_tb/PROG/dpif0/dmemload
add wave -noupdate -group dpif0 /dcache_tb/PROG/dpif0/dmemstore
add wave -noupdate -group dpif0 /dcache_tb/PROG/dpif0/dmemaddr
add wave -noupdate -expand -group {CACHE 0} /dcache_tb/PROG/cif0/iwait
add wave -noupdate -expand -group {CACHE 0} /dcache_tb/PROG/cif0/dwait
add wave -noupdate -expand -group {CACHE 0} /dcache_tb/PROG/cif0/iREN
add wave -noupdate -expand -group {CACHE 0} /dcache_tb/PROG/cif0/dREN
add wave -noupdate -expand -group {CACHE 0} /dcache_tb/PROG/cif0/dWEN
add wave -noupdate -expand -group {CACHE 0} /dcache_tb/PROG/cif0/iload
add wave -noupdate -expand -group {CACHE 0} /dcache_tb/PROG/cif0/dload
add wave -noupdate -expand -group {CACHE 0} /dcache_tb/PROG/cif0/dstore
add wave -noupdate -expand -group {CACHE 0} /dcache_tb/PROG/cif0/iaddr
add wave -noupdate -expand -group {CACHE 0} /dcache_tb/PROG/cif0/daddr
add wave -noupdate -expand -group {CACHE 0} /dcache_tb/PROG/cif0/ccwait
add wave -noupdate -expand -group {CACHE 0} /dcache_tb/PROG/cif0/ccinv
add wave -noupdate -expand -group {CACHE 0} /dcache_tb/PROG/cif0/ccwrite
add wave -noupdate -expand -group {CACHE 0} /dcache_tb/PROG/cif0/cctrans
add wave -noupdate -expand -group {CACHE 0} /dcache_tb/PROG/cif0/ccsnoopaddr
add wave -noupdate -group {DP 1} /dcache_tb/PROG/dpif1/halt
add wave -noupdate -group {DP 1} /dcache_tb/PROG/dpif1/ihit
add wave -noupdate -group {DP 1} /dcache_tb/PROG/dpif1/imemREN
add wave -noupdate -group {DP 1} /dcache_tb/PROG/dpif1/imemload
add wave -noupdate -group {DP 1} /dcache_tb/PROG/dpif1/imemaddr
add wave -noupdate -group {DP 1} /dcache_tb/PROG/dpif1/dhit
add wave -noupdate -group {DP 1} /dcache_tb/PROG/dpif1/datomic
add wave -noupdate -group {DP 1} /dcache_tb/PROG/dpif1/dmemREN
add wave -noupdate -group {DP 1} /dcache_tb/PROG/dpif1/dmemWEN
add wave -noupdate -group {DP 1} /dcache_tb/PROG/dpif1/flushed
add wave -noupdate -group {DP 1} /dcache_tb/PROG/dpif1/dmemload
add wave -noupdate -group {DP 1} /dcache_tb/PROG/dpif1/dmemstore
add wave -noupdate -group {DP 1} /dcache_tb/PROG/dpif1/dmemaddr
add wave -noupdate -group {CACHE 1} /dcache_tb/PROG/cif1/iwait
add wave -noupdate -group {CACHE 1} /dcache_tb/PROG/cif1/dwait
add wave -noupdate -group {CACHE 1} /dcache_tb/PROG/cif1/iREN
add wave -noupdate -group {CACHE 1} /dcache_tb/PROG/cif1/dREN
add wave -noupdate -group {CACHE 1} /dcache_tb/PROG/cif1/dWEN
add wave -noupdate -group {CACHE 1} /dcache_tb/PROG/cif1/iload
add wave -noupdate -group {CACHE 1} /dcache_tb/PROG/cif1/dload
add wave -noupdate -group {CACHE 1} /dcache_tb/PROG/cif1/dstore
add wave -noupdate -group {CACHE 1} /dcache_tb/PROG/cif1/iaddr
add wave -noupdate -group {CACHE 1} /dcache_tb/PROG/cif1/daddr
add wave -noupdate -group {CACHE 1} /dcache_tb/PROG/cif1/ccwait
add wave -noupdate -group {CACHE 1} /dcache_tb/PROG/cif1/ccinv
add wave -noupdate -group {CACHE 1} /dcache_tb/PROG/cif1/ccwrite
add wave -noupdate -group {CACHE 1} /dcache_tb/PROG/cif1/cctrans
add wave -noupdate -group {CACHE 1} /dcache_tb/PROG/cif1/ccsnoopaddr
add wave -noupdate -expand -group {Memory Control} /dcache_tb/MC/CLK
add wave -noupdate -expand -group {Memory Control} /dcache_tb/MC/nRST
add wave -noupdate -expand -group {Memory Control} /dcache_tb/MC/state
add wave -noupdate -expand -group {Memory Control} /dcache_tb/MC/nxt_state
add wave -noupdate -expand -group {Memory Control} /dcache_tb/MC/nxt_cache
add wave -noupdate -expand -group {Memory Control} /dcache_tb/MC/curr_cache
add wave -noupdate -expand -group {Memory Control} /dcache_tb/MC/snoop
add wave -noupdate -expand -group {Memory Control} /dcache_tb/MC/nxt_snoop
add wave -noupdate -expand -group {Memory Control} /dcache_tb/MC/snoopfrom
add wave -noupdate -expand -group {Memory Control} /dcache_tb/MC/nxt_snoopfrom
add wave -noupdate -expand -group {Memory Control} /dcache_tb/MC/index
add wave -noupdate -expand -group {DUT0 CACHE 0} /dcache_tb/DUT0/CLK
add wave -noupdate -expand -group {DUT0 CACHE 0} /dcache_tb/DUT0/nRST
add wave -noupdate -expand -group {DUT0 CACHE 0} /dcache_tb/DUT0/left_tag
add wave -noupdate -expand -group {DUT0 CACHE 0} /dcache_tb/DUT0/right_tag
add wave -noupdate -expand -group {DUT0 CACHE 0} /dcache_tb/DUT0/left_dirty
add wave -noupdate -expand -group {DUT0 CACHE 0} /dcache_tb/DUT0/right_dirty
add wave -noupdate -expand -group {DUT0 CACHE 0} /dcache_tb/DUT0/left_valid
add wave -noupdate -expand -group {DUT0 CACHE 0} /dcache_tb/DUT0/right_valid
add wave -noupdate -expand -group {DUT0 CACHE 0} /dcache_tb/DUT0/left_data0
add wave -noupdate -expand -group {DUT0 CACHE 0} /dcache_tb/DUT0/left_data1
add wave -noupdate -expand -group {DUT0 CACHE 0} /dcache_tb/DUT0/right_data0
add wave -noupdate -expand -group {DUT0 CACHE 0} /dcache_tb/DUT0/right_data1
add wave -noupdate -expand -group {DUT0 CACHE 0} /dcache_tb/DUT0/dcache_addr
add wave -noupdate -expand -group {DUT0 CACHE 0} /dcache_tb/DUT0/frame
add wave -noupdate -expand -group {DUT0 CACHE 0} /dcache_tb/DUT0/state
add wave -noupdate -expand -group {DUT0 CACHE 0} /dcache_tb/DUT0/next_state
add wave -noupdate -expand -group {DUT0 CACHE 0} /dcache_tb/DUT0/hit_counter
add wave -noupdate -expand -group {DUT0 CACHE 0} /dcache_tb/DUT0/next_hit_counter
add wave -noupdate -expand -group {DUT0 CACHE 0} /dcache_tb/DUT0/flush_count
add wave -noupdate -expand -group {DUT0 CACHE 0} /dcache_tb/DUT0/next_flush_count
add wave -noupdate -expand -group {DUT0 CACHE 0} /dcache_tb/DUT0/flush_index
add wave -noupdate -expand -group {DUT0 CACHE 0} /dcache_tb/DUT0/ind
add wave -noupdate -expand -group {DUT0 CACHE 0} /dcache_tb/DUT0/snooptag
add wave -noupdate -expand -group {DUT0 CACHE 0} /dcache_tb/DUT0/snoopidx
add wave -noupdate -expand -group {DUT0 CACHE 0} /dcache_tb/DUT0/snoopoff
add wave -noupdate -expand -group {DUT1 CACHE 1} /dcache_tb/DUT1/CLK
add wave -noupdate -expand -group {DUT1 CACHE 1} /dcache_tb/DUT1/nRST
add wave -noupdate -expand -group {DUT1 CACHE 1} /dcache_tb/DUT1/left_tag
add wave -noupdate -expand -group {DUT1 CACHE 1} /dcache_tb/DUT1/right_tag
add wave -noupdate -expand -group {DUT1 CACHE 1} /dcache_tb/DUT1/left_dirty
add wave -noupdate -expand -group {DUT1 CACHE 1} /dcache_tb/DUT1/right_dirty
add wave -noupdate -expand -group {DUT1 CACHE 1} /dcache_tb/DUT1/left_valid
add wave -noupdate -expand -group {DUT1 CACHE 1} /dcache_tb/DUT1/right_valid
add wave -noupdate -expand -group {DUT1 CACHE 1} /dcache_tb/DUT1/left_data0
add wave -noupdate -expand -group {DUT1 CACHE 1} /dcache_tb/DUT1/left_data1
add wave -noupdate -expand -group {DUT1 CACHE 1} /dcache_tb/DUT1/right_data0
add wave -noupdate -expand -group {DUT1 CACHE 1} /dcache_tb/DUT1/right_data1
add wave -noupdate -expand -group {DUT1 CACHE 1} /dcache_tb/DUT1/dcache_addr
add wave -noupdate -expand -group {DUT1 CACHE 1} /dcache_tb/DUT1/frame
add wave -noupdate -expand -group {DUT1 CACHE 1} /dcache_tb/DUT1/state
add wave -noupdate -expand -group {DUT1 CACHE 1} /dcache_tb/DUT1/next_state
add wave -noupdate -expand -group {DUT1 CACHE 1} /dcache_tb/DUT1/hit_counter
add wave -noupdate -expand -group {DUT1 CACHE 1} /dcache_tb/DUT1/next_hit_counter
add wave -noupdate -expand -group {DUT1 CACHE 1} /dcache_tb/DUT1/flush_count
add wave -noupdate -expand -group {DUT1 CACHE 1} /dcache_tb/DUT1/next_flush_count
add wave -noupdate -expand -group {DUT1 CACHE 1} /dcache_tb/DUT1/flush_index
add wave -noupdate -expand -group {DUT1 CACHE 1} /dcache_tb/DUT1/ind
add wave -noupdate -expand -group {DUT1 CACHE 1} /dcache_tb/DUT1/snooptag
add wave -noupdate -expand -group {DUT1 CACHE 1} /dcache_tb/DUT1/snoopidx
add wave -noupdate -expand -group {DUT1 CACHE 1} /dcache_tb/DUT1/snoopoff
add wave -noupdate {/dcache_tb/ccif/dwait[0]}
add wave -noupdate -expand -group RAM /dcache_tb/DUTRAM/ramif/ramREN
add wave -noupdate -expand -group RAM /dcache_tb/DUTRAM/ramif/ramWEN
add wave -noupdate -expand -group RAM /dcache_tb/DUTRAM/ramif/ramaddr
add wave -noupdate -expand -group RAM /dcache_tb/DUTRAM/ramif/ramstore
add wave -noupdate -expand -group RAM /dcache_tb/DUTRAM/ramif/ramload
add wave -noupdate -expand -group RAM /dcache_tb/DUTRAM/ramif/ramstate
add wave -noupdate -expand -group RAM /dcache_tb/DUTRAM/ramif/memREN
add wave -noupdate -expand -group RAM /dcache_tb/DUTRAM/ramif/memWEN
add wave -noupdate -expand -group RAM /dcache_tb/DUTRAM/ramif/memaddr
add wave -noupdate -expand -group RAM /dcache_tb/DUTRAM/ramif/memstore
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {35931 ps} 0}
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
WaveRestoreZoom {8752 ps} {66502 ps}
