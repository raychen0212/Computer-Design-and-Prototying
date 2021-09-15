onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /control_unit_tb/CLK
add wave -noupdate /control_unit_tb/nRST
add wave -noupdate /control_unit_tb/DUT/cuif/instr
add wave -noupdate /control_unit_tb/DUT/cuif/opcode
add wave -noupdate /control_unit_tb/DUT/cuif/rs
add wave -noupdate /control_unit_tb/DUT/cuif/rt
add wave -noupdate /control_unit_tb/DUT/cuif/rd
add wave -noupdate /control_unit_tb/DUT/cuif/funct
add wave -noupdate /control_unit_tb/DUT/cuif/shamt
add wave -noupdate -radix hexadecimal /control_unit_tb/DUT/cuif/imm
add wave -noupdate /control_unit_tb/DUT/cuif/addr
add wave -noupdate /control_unit_tb/DUT/cuif/RegWr
add wave -noupdate /control_unit_tb/DUT/cuif/halt
add wave -noupdate /control_unit_tb/DUT/cuif/ALUsrc
add wave -noupdate /control_unit_tb/DUT/cuif/iREN
add wave -noupdate /control_unit_tb/DUT/cuif/dREN
add wave -noupdate /control_unit_tb/DUT/cuif/dWEN
add wave -noupdate /control_unit_tb/DUT/cuif/equal
add wave -noupdate /control_unit_tb/DUT/cuif/RegDst
add wave -noupdate /control_unit_tb/DUT/cuif/PCsrc
add wave -noupdate /control_unit_tb/DUT/cuif/ExtOp
add wave -noupdate /control_unit_tb/DUT/cuif/MemToReg
add wave -noupdate /control_unit_tb/DUT/cuif/ALUOp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {14 ns} 0}
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
WaveRestoreZoom {0 ns} {462 ns}
