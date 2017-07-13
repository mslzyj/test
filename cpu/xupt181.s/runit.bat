set path==%path%;C:\Novas\Debussy\bin

vlib work
vlog -vlog01compat -work work -f file.list
vsim -c -hazards work.test -pli C:/Novas/Debussy/share/PLI/modelsim_pli/WINNT/novas.dll -do "run -all; exit"