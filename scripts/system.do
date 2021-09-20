onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/DUT/CPU/DP/conif/alu_op
add wave -noupdate /system_tb/DUT/CPU/DP/con_func/alu_g
add wave -noupdate /system_tb/DUT/CPU/DP/conif/rs
add wave -noupdate /system_tb/DUT/CPU/DP/conif/rt
add wave -noupdate /system_tb/DUT/CPU/DP/conif/rd
add wave -noupdate /system_tb/DUT/CPU/DP/conif/memRead
add wave -noupdate /system_tb/DUT/CPU/DP/conif/memtoreg
add wave -noupdate /system_tb/DUT/CPU/DP/conif/memWr
add wave -noupdate /system_tb/DUT/CPU/DP/conif/regWr
add wave -noupdate /system_tb/DUT/CPU/DP/conif/aluSrc
add wave -noupdate /system_tb/DUT/CPU/DP/conif/regDst
add wave -noupdate /system_tb/DUT/CPU/DP/conif/pcSrc
add wave -noupdate /system_tb/DUT/CPU/DP/conif/extop
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate /system_tb/DUT/CPU/DP/regif/wdat
add wave -noupdate /system_tb/DUT/CPU/DP/regif/rdat1
add wave -noupdate /system_tb/DUT/CPU/DP/regif/rdat2
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate /system_tb/DUT/CPU/DP/conif/halt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1504292 ps} 0}
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
WaveRestoreZoom {1395 ns} {1631 ns}
