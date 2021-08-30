onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /alu_tb/CLK
add wave -noupdate /alu_tb/aluif/NegFlag
add wave -noupdate /alu_tb/aluif/Overflow
add wave -noupdate /alu_tb/aluif/ZeroFlag
add wave -noupdate /alu_tb/aluif/PortA
add wave -noupdate /alu_tb/aluif/PortB
add wave -noupdate /alu_tb/aluif/OutputPort
add wave -noupdate /alu_tb/aluif/ALUOP
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
WaveRestoreZoom {0 ns} {158 ns}
