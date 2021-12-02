onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate -group {cache control} -expand /system_tb/DUT/CPU/CC/ccif/iwait
add wave -noupdate -group {cache control} /system_tb/DUT/CPU/CC/ccif/dwait
add wave -noupdate -group {cache control} -expand /system_tb/DUT/CPU/CC/ccif/iREN
add wave -noupdate -group {cache control} /system_tb/DUT/CPU/CC/ccif/dREN
add wave -noupdate -group {cache control} /system_tb/DUT/CPU/CC/ccif/dWEN
add wave -noupdate -group {cache control} /system_tb/DUT/CPU/CC/ccif/iload
add wave -noupdate -group {cache control} /system_tb/DUT/CPU/CC/ccif/dload
add wave -noupdate -group {cache control} /system_tb/DUT/CPU/CC/ccif/dstore
add wave -noupdate -group {cache control} /system_tb/DUT/CPU/CC/ccif/iaddr
add wave -noupdate -group {cache control} /system_tb/DUT/CPU/CC/ccif/daddr
add wave -noupdate -group {cache control} /system_tb/DUT/CPU/CC/ccif/ccwait
add wave -noupdate -group {cache control} /system_tb/DUT/CPU/CC/ccif/ccinv
add wave -noupdate -group {cache control} /system_tb/DUT/CPU/CC/ccif/ccwrite
add wave -noupdate -group {cache control} /system_tb/DUT/CPU/CC/ccif/cctrans
add wave -noupdate -group {cache control} /system_tb/DUT/CPU/CC/ccif/ccsnoopaddr
add wave -noupdate /system_tb/DUT/CPU/CC/state
add wave -noupdate /system_tb/DUT/CPU/CC/nxt_state
add wave -noupdate /system_tb/DUT/CPU/CC/nxt_cache
add wave -noupdate /system_tb/DUT/CPU/CC/curr_cache
add wave -noupdate /system_tb/DUT/CPU/CC/snoop
add wave -noupdate /system_tb/DUT/CPU/CC/nxt_snoop
add wave -noupdate /system_tb/DUT/CPU/CC/snoopfrom
add wave -noupdate /system_tb/DUT/CPU/CC/nxt_snoopfrom
add wave -noupdate /system_tb/DUT/CPU/CC/index
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/PC_INIT
add wave -noupdate -group DP0 /system_tb/DUT/CPU/dcif0/halt
add wave -noupdate -group DP0 /system_tb/DUT/CPU/dcif0/ihit
add wave -noupdate -group DP0 /system_tb/DUT/CPU/dcif0/imemREN
add wave -noupdate -group DP0 /system_tb/DUT/CPU/dcif0/imemload
add wave -noupdate -group DP0 /system_tb/DUT/CPU/dcif0/imemaddr
add wave -noupdate -group DP0 /system_tb/DUT/CPU/dcif0/dhit
add wave -noupdate -group DP0 /system_tb/DUT/CPU/dcif0/datomic
add wave -noupdate -group DP0 /system_tb/DUT/CPU/dcif0/dmemREN
add wave -noupdate -group DP0 /system_tb/DUT/CPU/dcif0/dmemWEN
add wave -noupdate -group DP0 /system_tb/DUT/CPU/dcif0/flushed
add wave -noupdate -group DP0 /system_tb/DUT/CPU/dcif0/dmemload
add wave -noupdate -group DP0 /system_tb/DUT/CPU/dcif0/dmemstore
add wave -noupdate -group DP0 /system_tb/DUT/CPU/dcif0/dmemaddr
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/imm
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/wdat
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/muxB
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/check
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/pc
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/next_pc
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/pc4
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/jumpaddr
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/pcen
add wave -noupdate -expand -group CU0 /system_tb/DUT/CPU/DP0/cuif/instr
add wave -noupdate -expand -group CU0 /system_tb/DUT/CPU/DP0/cuif/opcode
add wave -noupdate -expand -group CU0 /system_tb/DUT/CPU/DP0/cuif/rs
add wave -noupdate -expand -group CU0 /system_tb/DUT/CPU/DP0/cuif/rt
add wave -noupdate -expand -group CU0 /system_tb/DUT/CPU/DP0/cuif/rd
add wave -noupdate -expand -group CU0 /system_tb/DUT/CPU/DP0/cuif/funct
add wave -noupdate -expand -group CU0 /system_tb/DUT/CPU/DP0/cuif/shamt
add wave -noupdate -expand -group CU0 /system_tb/DUT/CPU/DP0/cuif/imm
add wave -noupdate -expand -group CU0 /system_tb/DUT/CPU/DP0/cuif/addr
add wave -noupdate -expand -group CU0 /system_tb/DUT/CPU/DP0/cuif/RegWr
add wave -noupdate -expand -group CU0 /system_tb/DUT/CPU/DP0/cuif/halt
add wave -noupdate -expand -group CU0 /system_tb/DUT/CPU/DP0/cuif/ALUsrc
add wave -noupdate -expand -group CU0 /system_tb/DUT/CPU/DP0/cuif/iREN
add wave -noupdate -expand -group CU0 /system_tb/DUT/CPU/DP0/cuif/dREN
add wave -noupdate -expand -group CU0 /system_tb/DUT/CPU/DP0/cuif/dWEN
add wave -noupdate -expand -group CU0 /system_tb/DUT/CPU/DP0/cuif/stopread
add wave -noupdate -expand -group CU0 /system_tb/DUT/CPU/DP0/cuif/RegDst
add wave -noupdate -expand -group CU0 /system_tb/DUT/CPU/DP0/cuif/PCsrc
add wave -noupdate -expand -group CU0 /system_tb/DUT/CPU/DP0/cuif/ExtOp
add wave -noupdate -expand -group CU0 /system_tb/DUT/CPU/DP0/cuif/MemToReg
add wave -noupdate -expand -group CU0 /system_tb/DUT/CPU/DP0/cuif/ALUOp
add wave -noupdate -group cache0 /system_tb/DUT/CPU/CM0/cif/iwait
add wave -noupdate -group cache0 /system_tb/DUT/CPU/CM0/cif/dwait
add wave -noupdate -group cache0 /system_tb/DUT/CPU/CM0/cif/iREN
add wave -noupdate -group cache0 /system_tb/DUT/CPU/CM0/cif/dREN
add wave -noupdate -group cache0 /system_tb/DUT/CPU/CM0/cif/dWEN
add wave -noupdate -group cache0 /system_tb/DUT/CPU/CM0/cif/iload
add wave -noupdate -group cache0 /system_tb/DUT/CPU/CM0/cif/dload
add wave -noupdate -group cache0 /system_tb/DUT/CPU/CM0/cif/dstore
add wave -noupdate -group cache0 /system_tb/DUT/CPU/CM0/cif/iaddr
add wave -noupdate -group cache0 /system_tb/DUT/CPU/CM0/cif/daddr
add wave -noupdate -group cache0 /system_tb/DUT/CPU/CM0/cif/ccwait
add wave -noupdate -group cache0 /system_tb/DUT/CPU/CM0/cif/ccinv
add wave -noupdate -group cache0 /system_tb/DUT/CPU/CM0/cif/ccwrite
add wave -noupdate -group cache0 /system_tb/DUT/CPU/CM0/cif/cctrans
add wave -noupdate -group cache0 /system_tb/DUT/CPU/CM0/cif/ccsnoopaddr
add wave -noupdate -group cache0 -group icache0 /system_tb/DUT/CPU/CM0/ICACHE/CLK
add wave -noupdate -group cache0 -group icache0 /system_tb/DUT/CPU/CM0/ICACHE/nRST
add wave -noupdate -group cache0 -group icache0 /system_tb/DUT/CPU/CM0/ICACHE/hit
add wave -noupdate -group cache0 -group icache0 /system_tb/DUT/CPU/CM0/ICACHE/miss
add wave -noupdate -group cache0 -group icache0 /system_tb/DUT/CPU/CM0/ICACHE/debug
add wave -noupdate -group cache0 -group icache0 /system_tb/DUT/CPU/CM0/ICACHE/icache_addr
add wave -noupdate -group cache0 -group icache0 /system_tb/DUT/CPU/CM0/ICACHE/frame
add wave -noupdate -group cache0 -group icache0 /system_tb/DUT/CPU/CM0/ICACHE/state
add wave -noupdate -group cache0 -group icache0 /system_tb/DUT/CPU/CM0/ICACHE/nxt_state
add wave -noupdate -group cache0 -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/CLK
add wave -noupdate -group cache0 -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/nRST
add wave -noupdate -group cache0 -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/link_valid
add wave -noupdate -group cache0 -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_link_valid
add wave -noupdate -group cache0 -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/link_reg
add wave -noupdate -group cache0 -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_link_reg
add wave -noupdate -group cache0 -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/left_tag
add wave -noupdate -group cache0 -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/right_tag
add wave -noupdate -group cache0 -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/left_dirty
add wave -noupdate -group cache0 -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/right_dirty
add wave -noupdate -group cache0 -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/left_valid
add wave -noupdate -group cache0 -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/right_valid
add wave -noupdate -group cache0 -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/left_data0
add wave -noupdate -group cache0 -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/left_data1
add wave -noupdate -group cache0 -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/right_data0
add wave -noupdate -group cache0 -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/right_data1
add wave -noupdate -group cache0 -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/dcache_addr
add wave -noupdate -group cache0 -expand -group dcache0 -expand -subitemconfig {{/system_tb/DUT/CPU/CM0/DCACHE/frame[1]} -expand} /system_tb/DUT/CPU/CM0/DCACHE/frame
add wave -noupdate -group cache0 -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/state
add wave -noupdate -group cache0 -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_state
add wave -noupdate -group cache0 -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/hit_counter
add wave -noupdate -group cache0 -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_hit_counter
add wave -noupdate -group cache0 -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/flush_count
add wave -noupdate -group cache0 -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_flush_count
add wave -noupdate -group cache0 -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/flush_index
add wave -noupdate -group cache0 -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/snooptag
add wave -noupdate -group cache0 -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/snoopidx
add wave -noupdate -group cache0 -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/snoopoff
add wave -noupdate -group DP1 -expand -group DP1 /system_tb/DUT/CPU/DP1/PC_INIT
add wave -noupdate -group DP1 -expand -group DP1 /system_tb/DUT/CPU/dcif1/halt
add wave -noupdate -group DP1 -expand -group DP1 /system_tb/DUT/CPU/dcif1/ihit
add wave -noupdate -group DP1 -expand -group DP1 /system_tb/DUT/CPU/dcif1/imemREN
add wave -noupdate -group DP1 -expand -group DP1 /system_tb/DUT/CPU/dcif1/imemload
add wave -noupdate -group DP1 -expand -group DP1 /system_tb/DUT/CPU/dcif1/imemaddr
add wave -noupdate -group DP1 -expand -group DP1 /system_tb/DUT/CPU/dcif1/dhit
add wave -noupdate -group DP1 -expand -group DP1 /system_tb/DUT/CPU/dcif1/datomic
add wave -noupdate -group DP1 -expand -group DP1 /system_tb/DUT/CPU/dcif1/dmemREN
add wave -noupdate -group DP1 -expand -group DP1 /system_tb/DUT/CPU/dcif1/dmemWEN
add wave -noupdate -group DP1 -expand -group DP1 /system_tb/DUT/CPU/dcif1/flushed
add wave -noupdate -group DP1 -expand -group DP1 /system_tb/DUT/CPU/dcif1/dmemload
add wave -noupdate -group DP1 -expand -group DP1 /system_tb/DUT/CPU/dcif1/dmemstore
add wave -noupdate -group DP1 -expand -group DP1 /system_tb/DUT/CPU/dcif1/dmemaddr
add wave -noupdate -group DP1 -expand -group DP1 /system_tb/DUT/CPU/DP1/CLK
add wave -noupdate -group DP1 -expand -group DP1 /system_tb/DUT/CPU/DP1/nRST
add wave -noupdate -group DP1 -expand -group DP1 /system_tb/DUT/CPU/DP1/imm
add wave -noupdate -group DP1 -expand -group DP1 /system_tb/DUT/CPU/DP1/wdat
add wave -noupdate -group DP1 -expand -group DP1 /system_tb/DUT/CPU/DP1/muxB
add wave -noupdate -group DP1 -expand -group DP1 /system_tb/DUT/CPU/DP1/check
add wave -noupdate -group DP1 -expand -group DP1 /system_tb/DUT/CPU/DP1/pc
add wave -noupdate -group DP1 -expand -group DP1 /system_tb/DUT/CPU/DP1/next_pc
add wave -noupdate -group DP1 -expand -group DP1 /system_tb/DUT/CPU/DP1/pc4
add wave -noupdate -group DP1 -expand -group DP1 /system_tb/DUT/CPU/DP1/jumpaddr
add wave -noupdate -group DP1 -expand -group DP1 /system_tb/DUT/CPU/DP1/pcen
add wave -noupdate -expand -group CU1 /system_tb/DUT/CPU/DP1/cuif/instr
add wave -noupdate -expand -group CU1 /system_tb/DUT/CPU/DP1/cuif/opcode
add wave -noupdate -expand -group CU1 /system_tb/DUT/CPU/DP1/cuif/rs
add wave -noupdate -expand -group CU1 /system_tb/DUT/CPU/DP1/cuif/rt
add wave -noupdate -expand -group CU1 /system_tb/DUT/CPU/DP1/cuif/rd
add wave -noupdate -expand -group CU1 /system_tb/DUT/CPU/DP1/cuif/funct
add wave -noupdate -expand -group CU1 /system_tb/DUT/CPU/DP1/cuif/shamt
add wave -noupdate -expand -group CU1 /system_tb/DUT/CPU/DP1/cuif/imm
add wave -noupdate -expand -group CU1 /system_tb/DUT/CPU/DP1/cuif/addr
add wave -noupdate -expand -group CU1 /system_tb/DUT/CPU/DP1/cuif/RegWr
add wave -noupdate -expand -group CU1 /system_tb/DUT/CPU/DP1/cuif/halt
add wave -noupdate -expand -group CU1 /system_tb/DUT/CPU/DP1/cuif/ALUsrc
add wave -noupdate -expand -group CU1 /system_tb/DUT/CPU/DP1/cuif/iREN
add wave -noupdate -expand -group CU1 /system_tb/DUT/CPU/DP1/cuif/dREN
add wave -noupdate -expand -group CU1 /system_tb/DUT/CPU/DP1/cuif/dWEN
add wave -noupdate -expand -group CU1 /system_tb/DUT/CPU/DP1/cuif/branch
add wave -noupdate -expand -group CU1 /system_tb/DUT/CPU/DP1/cuif/jump
add wave -noupdate -expand -group CU1 /system_tb/DUT/CPU/DP1/cuif/stopread
add wave -noupdate -expand -group CU1 /system_tb/DUT/CPU/DP1/cuif/RegDst
add wave -noupdate -expand -group CU1 /system_tb/DUT/CPU/DP1/cuif/PCsrc
add wave -noupdate -expand -group CU1 /system_tb/DUT/CPU/DP1/cuif/ExtOp
add wave -noupdate -expand -group CU1 /system_tb/DUT/CPU/DP1/cuif/MemToReg
add wave -noupdate -expand -group CU1 /system_tb/DUT/CPU/DP1/cuif/ALUOp
add wave -noupdate -expand -group CACHE1 /system_tb/DUT/CPU/CM1/cif/iwait
add wave -noupdate -expand -group CACHE1 /system_tb/DUT/CPU/CM1/cif/dwait
add wave -noupdate -expand -group CACHE1 /system_tb/DUT/CPU/CM1/cif/iREN
add wave -noupdate -expand -group CACHE1 /system_tb/DUT/CPU/CM1/cif/dREN
add wave -noupdate -expand -group CACHE1 /system_tb/DUT/CPU/CM1/cif/dWEN
add wave -noupdate -expand -group CACHE1 /system_tb/DUT/CPU/CM1/cif/iload
add wave -noupdate -expand -group CACHE1 /system_tb/DUT/CPU/CM1/cif/dload
add wave -noupdate -expand -group CACHE1 /system_tb/DUT/CPU/CM1/cif/dstore
add wave -noupdate -expand -group CACHE1 /system_tb/DUT/CPU/CM1/cif/iaddr
add wave -noupdate -expand -group CACHE1 /system_tb/DUT/CPU/CM1/cif/daddr
add wave -noupdate -expand -group CACHE1 /system_tb/DUT/CPU/CM1/cif/ccwait
add wave -noupdate -expand -group CACHE1 /system_tb/DUT/CPU/CM1/cif/ccinv
add wave -noupdate -expand -group CACHE1 /system_tb/DUT/CPU/CM1/cif/ccwrite
add wave -noupdate -expand -group CACHE1 /system_tb/DUT/CPU/CM1/cif/cctrans
add wave -noupdate -expand -group CACHE1 /system_tb/DUT/CPU/CM1/cif/ccsnoopaddr
add wave -noupdate -expand -group CACHE1 -group icache1 /system_tb/DUT/CPU/CM1/ICACHE/CLK
add wave -noupdate -expand -group CACHE1 -group icache1 /system_tb/DUT/CPU/CM1/ICACHE/nRST
add wave -noupdate -expand -group CACHE1 -group icache1 /system_tb/DUT/CPU/CM1/ICACHE/hit
add wave -noupdate -expand -group CACHE1 -group icache1 /system_tb/DUT/CPU/CM1/ICACHE/miss
add wave -noupdate -expand -group CACHE1 -group icache1 /system_tb/DUT/CPU/CM1/ICACHE/debug
add wave -noupdate -expand -group CACHE1 -group icache1 /system_tb/DUT/CPU/CM1/ICACHE/icache_addr
add wave -noupdate -expand -group CACHE1 -group icache1 /system_tb/DUT/CPU/CM1/ICACHE/frame
add wave -noupdate -expand -group CACHE1 -group icache1 /system_tb/DUT/CPU/CM1/ICACHE/state
add wave -noupdate -expand -group CACHE1 -group icache1 /system_tb/DUT/CPU/CM1/ICACHE/nxt_state
add wave -noupdate -expand -group CACHE1 -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/CLK
add wave -noupdate -expand -group CACHE1 -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/nRST
add wave -noupdate -expand -group CACHE1 -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/link_valid
add wave -noupdate -expand -group CACHE1 -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_link_valid
add wave -noupdate -expand -group CACHE1 -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/link_reg
add wave -noupdate -expand -group CACHE1 -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_link_reg
add wave -noupdate -expand -group CACHE1 -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/left_tag
add wave -noupdate -expand -group CACHE1 -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/right_tag
add wave -noupdate -expand -group CACHE1 -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/left_dirty
add wave -noupdate -expand -group CACHE1 -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/right_dirty
add wave -noupdate -expand -group CACHE1 -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/left_valid
add wave -noupdate -expand -group CACHE1 -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/right_valid
add wave -noupdate -expand -group CACHE1 -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/left_data0
add wave -noupdate -expand -group CACHE1 -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/left_data1
add wave -noupdate -expand -group CACHE1 -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/right_data0
add wave -noupdate -expand -group CACHE1 -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/right_data1
add wave -noupdate -expand -group CACHE1 -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/dcache_addr
add wave -noupdate -expand -group CACHE1 -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/frame
add wave -noupdate -expand -group CACHE1 -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/state
add wave -noupdate -expand -group CACHE1 -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_state
add wave -noupdate -expand -group CACHE1 -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/hit_counter
add wave -noupdate -expand -group CACHE1 -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_hit_counter
add wave -noupdate -expand -group CACHE1 -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/flush_count
add wave -noupdate -expand -group CACHE1 -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_flush_count
add wave -noupdate -expand -group CACHE1 -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/flush_index
add wave -noupdate -expand -group CACHE1 -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/snooptag
add wave -noupdate -expand -group CACHE1 -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/snoopidx
add wave -noupdate -expand -group CACHE1 -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/snoopoff
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5867332 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 176
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
WaveRestoreZoom {5240418 ps} {6669418 ps}
