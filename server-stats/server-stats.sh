#!/bin/bash


cpu_usage(){
echo CPU USAGE
top -bn1 | grep "Cpu(s)" | awk '{print "total CPU usage is "100-$8"%"}'
}

memory_usage(){
echo MEMORY USAGE
free -m | grep "Mem:" | awk '{print "Total Memory usage: Used:"$3", Free:"$4", Percentage:"sprintf("%.1f", ($3/$2)*100)"%"""}'
}

data_usage(){
echo DISK USAGE
df -h | grep '/dev/nvme0n1p6' | awk '{print "Total disk usage: Used: "$3", Free:"$4", Percentage: "$5""}'
}

cpu_top5(){
echo TOP 5 CPU USAGE
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
}

mem_top5(){
echo TOP 5 MEM USAGE
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
}


echo "welcome to my server stats"
echo ""
cpu_usage
echo ""
memory_usage
echo ""
data_usage
echo ""
cpu_top5
echo ""
mem_top5



