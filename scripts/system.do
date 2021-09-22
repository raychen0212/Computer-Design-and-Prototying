onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/DUT/CPU/DP/CLK
add wave -noupdate /system_tb/DUT/CPU/DP/nRST
add wave -noupdate -expand -group DP /system_tb/DUT/CPU/DP/imm
add wave -noupdate -expand -group DP /system_tb/DUT/CPU/DP/wdat
add wave -noupdate -expand -group DP /system_tb/DUT/CPU/DP/pc
add wave -noupdate -expand -group DP /system_tb/DUT/CPU/DP/next_pc
add wave -noupdate -expand -group DP /system_tb/DUT/CPU/DP/pc4
add wave -noupdate -expand -group DP /system_tb/DUT/CPU/DP/jumpaddr
add wave -noupdate -expand -group DP /system_tb/DUT/CPU/DP/pcen
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/halt
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/datomic
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/flushed
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemaddr
add wave -noupdate -expand -group {control unit} /system_tb/DUT/CPU/DP/cuif/instr
add wave -noupdate -expand -group {control unit} /system_tb/DUT/CPU/DP/cuif/opcode
add wave -noupdate -expand -group {control unit} /system_tb/DUT/CPU/DP/cuif/rs
add wave -noupdate -expand -group {control unit} /system_tb/DUT/CPU/DP/cuif/rt
add wave -noupdate -expand -group {control unit} /system_tb/DUT/CPU/DP/cuif/rd
add wave -noupdate -expand -group {control unit} /system_tb/DUT/CPU/DP/cuif/funct
add wave -noupdate -expand -group {control unit} /system_tb/DUT/CPU/DP/cuif/shamt
add wave -noupdate -expand -group {control unit} /system_tb/DUT/CPU/DP/cuif/imm
add wave -noupdate -expand -group {control unit} /system_tb/DUT/CPU/DP/cuif/addr
add wave -noupdate -expand -group {control unit} /system_tb/DUT/CPU/DP/cuif/RegWr
add wave -noupdate -expand -group {control unit} /system_tb/DUT/CPU/DP/cuif/halt
add wave -noupdate -expand -group {control unit} /system_tb/DUT/CPU/DP/cuif/ALUsrc
add wave -noupdate -expand -group {control unit} /system_tb/DUT/CPU/DP/cuif/iREN
add wave -noupdate -expand -group {control unit} /system_tb/DUT/CPU/DP/cuif/dREN
add wave -noupdate -expand -group {control unit} /system_tb/DUT/CPU/DP/cuif/dWEN
add wave -noupdate -expand -group {control unit} /system_tb/DUT/CPU/DP/cuif/RegDst
add wave -noupdate -expand -group {control unit} /system_tb/DUT/CPU/DP/cuif/PCsrc
add wave -noupdate -expand -group {control unit} /system_tb/DUT/CPU/DP/cuif/ExtOp
add wave -noupdate -expand -group {control unit} /system_tb/DUT/CPU/DP/cuif/MemToReg
add wave -noupdate -expand -group {control unit} /system_tb/DUT/CPU/DP/cuif/ALUOp
add wave -noupdate -group {requst unit} /system_tb/DUT/CPU/DP/ruif/ihit
add wave -noupdate -group {requst unit} /system_tb/DUT/CPU/DP/ruif/dhit
add wave -noupdate -group {requst unit} /system_tb/DUT/CPU/DP/ruif/dREN
add wave -noupdate -group {requst unit} /system_tb/DUT/CPU/DP/ruif/dWEN
add wave -noupdate -group {requst unit} /system_tb/DUT/CPU/DP/ruif/dmemREN
add wave -noupdate -group {requst unit} /system_tb/DUT/CPU/DP/ruif/dmemWEN
add wave -noupdate -group alu /system_tb/DUT/CPU/DP/aluif/NegFlag
add wave -noupdate -group alu /system_tb/DUT/CPU/DP/aluif/Overflow
add wave -noupdate -group alu /system_tb/DUT/CPU/DP/aluif/ZeroFlag
add wave -noupdate -group alu -radix hexadecimal /system_tb/DUT/CPU/DP/aluif/PortA
add wave -noupdate -group alu /system_tb/DUT/CPU/DP/aluif/PortB
add wave -noupdate -group alu /system_tb/DUT/CPU/DP/aluif/OutputPort
add wave -noupdate -group alu /system_tb/DUT/CPU/DP/aluif/ALUOP
add wave -noupdate -expand -group registerfile /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate -expand -group registerfile /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -expand -group registerfile /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate -expand -group registerfile /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -expand -group registerfile /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -expand -group registerfile /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -expand -group registerfile /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/memREN
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/memWEN
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/memaddr
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/memstore
add wave -noupdate -expand /system_tb/DUT/CPU/DP/rf/reg_map
add wave -noupdate -expand -group {memory control} /system_tb/DUT/CPU/ccif/cif0/iwait
add wave -noupdate -expand -group {memory control} /system_tb/DUT/CPU/ccif/cif0/dwait
add wave -noupdate -expand -group {memory control} /system_tb/DUT/CPU/ccif/cif0/iREN
add wave -noupdate -expand -group {memory control} /system_tb/DUT/CPU/ccif/cif0/dREN
add wave -noupdate -expand -group {memory control} /system_tb/DUT/CPU/ccif/cif0/dWEN
add wave -noupdate -expand -group {memory control} /system_tb/DUT/CPU/ccif/cif0/iload
add wave -noupdate -expand -group {memory control} /system_tb/DUT/CPU/ccif/cif0/dload
add wave -noupdate -expand -group {memory control} /system_tb/DUT/CPU/ccif/cif0/dstore
add wave -noupdate -expand -group {memory control} /system_tb/DUT/CPU/ccif/cif0/iaddr
add wave -noupdate -expand -group {memory control} /system_tb/DUT/CPU/ccif/cif0/daddr
add wave -noupdate -expand -group {memory control} /system_tb/DUT/CPU/ccif/cif0/ccwait
add wave -noupdate -expand -group {memory control} /system_tb/DUT/CPU/ccif/cif0/ccinv
add wave -noupdate -expand -group {memory control} /system_tb/DUT/CPU/ccif/cif0/ccwrite
add wave -noupdate -expand -group {memory control} /system_tb/DUT/CPU/ccif/cif0/cctrans
add wave -noupdate -expand -group {memory control} /system_tb/DUT/CPU/ccif/cif0/ccsnoopaddr
add wave -noupdate -group if-id /system_tb/DUT/CPU/DP/ifidif/instr_i
add wave -noupdate -group if-id /system_tb/DUT/CPU/DP/ifidif/instr_o
add wave -noupdate -group if-id /system_tb/DUT/CPU/DP/ifidif/pc4_i
add wave -noupdate -group if-id /system_tb/DUT/CPU/DP/ifidif/pc4_o
add wave -noupdate -group if-id /system_tb/DUT/CPU/DP/ifidif/flush
add wave -noupdate -group if-id /system_tb/DUT/CPU/DP/ifidif/en
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/rdat1_i
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/rdat2_i
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/imm_i
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/pc4_i
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/jaddr_i
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/rdat1_o
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/rdat2_o
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/imm_o
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/pc4_o
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/jaddr_o
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/rt_i
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/rd_i
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/rd_o
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/rt_o
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/RegWr_i
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/halt_i
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/ALUsrc_i
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/dREN_i
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/dWEN_i
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/stopread_i
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/RegWr_o
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/halt_o
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/ALUsrc_o
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/dREN_o
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/dWEN_o
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/stopread_o
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/RegDst_i
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/MemToReg_i
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/PCsrc_i
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/ExtOp_i
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/RegDst_o
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/MemToReg_o
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/PCsrc_o
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/ExtOp_o
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/ALUOp_i
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/ALUOp_o
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/flush
add wave -noupdate -group id-ex /system_tb/DUT/CPU/DP/idexif/en
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/rdat2_i
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/imm_i
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/pc4_i
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/jaddr_i
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/branchaddr_i
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/OutputPort_i
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/rdat2_o
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/imm_o
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/pc4_o
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/jaddr_o
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/branchaddr_o
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/OutputPort_o
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/wsel_i
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/wsel_o
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/RegWr_i
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/halt_i
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/dREN_i
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/dWEN_i
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/ZeroFlag_i
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/stopread_i
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/RegWr_o
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/halt_o
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/dREN_o
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/dWEN_o
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/ZeroFlag_o
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/stopread_o
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/MemToReg_i
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/PCsrc_i
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/MemToReg_o
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/PCsrc_o
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/flush
add wave -noupdate -group ex-mem /system_tb/DUT/CPU/DP/exmemif/en
add wave -noupdate -group mem-wb /system_tb/DUT/CPU/DP/memwbif/imm_i
add wave -noupdate -group mem-wb /system_tb/DUT/CPU/DP/memwbif/pc4_i
add wave -noupdate -group mem-wb /system_tb/DUT/CPU/DP/memwbif/OutputPort_i
add wave -noupdate -group mem-wb /system_tb/DUT/CPU/DP/memwbif/dmemload_i
add wave -noupdate -group mem-wb /system_tb/DUT/CPU/DP/memwbif/imm_o
add wave -noupdate -group mem-wb /system_tb/DUT/CPU/DP/memwbif/pc4_o
add wave -noupdate -group mem-wb /system_tb/DUT/CPU/DP/memwbif/OutputPort_o
add wave -noupdate -group mem-wb /system_tb/DUT/CPU/DP/memwbif/dmemload_o
add wave -noupdate -group mem-wb /system_tb/DUT/CPU/DP/memwbif/wsel_i
add wave -noupdate -group mem-wb /system_tb/DUT/CPU/DP/memwbif/wsel_o
add wave -noupdate -group mem-wb /system_tb/DUT/CPU/DP/memwbif/RegWr_i
add wave -noupdate -group mem-wb /system_tb/DUT/CPU/DP/memwbif/halt_i
add wave -noupdate -group mem-wb /system_tb/DUT/CPU/DP/memwbif/stopread_i
add wave -noupdate -group mem-wb /system_tb/DUT/CPU/DP/memwbif/RegWr_o
add wave -noupdate -group mem-wb /system_tb/DUT/CPU/DP/memwbif/halt_o
add wave -noupdate -group mem-wb /system_tb/DUT/CPU/DP/memwbif/stopread_o
add wave -noupdate -group mem-wb /system_tb/DUT/CPU/DP/memwbif/MemToReg_i
add wave -noupdate -group mem-wb /system_tb/DUT/CPU/DP/memwbif/MemToReg_o
add wave -noupdate -group mem-wb /system_tb/DUT/CPU/DP/memwbif/flush
add wave -noupdate -group mem-wb /system_tb/DUT/CPU/DP/memwbif/en
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {527032 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 138
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
WaveRestoreZoom {1311047657 ps} {1311713282 ps}
