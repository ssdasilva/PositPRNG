onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_complete_sine_map_scheme/DUT/clk
add wave -noupdate /tb_complete_sine_map_scheme/DUT/rst
add wave -noupdate /tb_complete_sine_map_scheme/DUT/A
add wave -noupdate /tb_complete_sine_map_scheme/DUT/S
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {680720 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 174
configure wave -valuecolwidth 42
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {2625 ns}