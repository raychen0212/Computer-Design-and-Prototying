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
add wave -noupdate -expand -group DP /system_tb/DUT/CPU/DP/branchaddr
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
add wave -noupdate -expand -group {control unit} /system_tb/DUT/CPU/DP/cuif/equal
add wave -noupdate -expand -group {control unit} /system_tb/DUT/CPU/DP/cuif/RegDst
add wave -noupdate -expand -group {control unit} /system_tb/DUT/CPU/DP/cuif/PCsrc
add wave -noupdate -expand -group {control unit} /system_tb/DUT/CPU/DP/cuif/ExtOp
add wave -noupdate -expand -group {control unit} /system_tb/DUT/CPU/DP/cuif/MemToReg
add wave -noupdate -expand -group {control unit} /system_tb/DUT/CPU/DP/cuif/ALUOp
add wave -noupdate -expand -group {requst unit} /system_tb/DUT/CPU/DP/ruif/ihit
add wave -noupdate -expand -group {requst unit} /system_tb/DUT/CPU/DP/ruif/dhit
add wave -noupdate -expand -group {requst unit} /system_tb/DUT/CPU/DP/ruif/dREN
add wave -noupdate -expand -group {requst unit} /system_tb/DUT/CPU/DP/ruif/dWEN
add wave -noupdate -expand -group {requst unit} /system_tb/DUT/CPU/DP/ruif/dmemREN
add wave -noupdate -expand -group {requst unit} /system_tb/DUT/CPU/DP/ruif/dmemWEN
add wave -noupdate -expand -group alu /system_tb/DUT/CPU/DP/aluif/NegFlag
add wave -noupdate -expand -group alu /system_tb/DUT/CPU/DP/aluif/Overflow
add wave -noupdate -expand -group alu /system_tb/DUT/CPU/DP/aluif/ZeroFlag
add wave -noupdate -expand -group alu -radix hexadecimal /system_tb/DUT/CPU/DP/aluif/PortA
add wave -noupdate -expand -group alu /system_tb/DUT/CPU/DP/aluif/PortB
add wave -noupdate -expand -group alu /system_tb/DUT/CPU/DP/aluif/OutputPort
add wave -noupdate -expand -group alu /system_tb/DUT/CPU/DP/aluif/ALUOP
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
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {889340 ps} 0}
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
WaveRestoreZoom {809600 ps} {1062600 ps}
