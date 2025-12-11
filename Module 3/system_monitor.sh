#!/bin/bash

############################################
# COLORS
############################################
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
RESET="\e[0m"

############################################
# SIMPLE FUNCTIONS
############################################

show_processes() {
    echo -e "${BLUE}---- Running Processes ----${RESET}"
    ps aux
}

show_kernel() {
    echo -e "${BLUE}---- Kernel Information ----${RESET}"
    uname -a
}

show_disk_usage() {
    echo -e "${BLUE}---- Disk Usage ----${RESET}"
    df -h
}

show_uptime() {
    echo -e "${BLUE}---- System Uptime ----${RESET}"
    uptime
}

############################################
# MID-LEVEL FUNCTIONS
############################################

memory_summary() {
    echo -e "${CYAN}---- Memory Summary ----${RESET}"
    free -m | awk '
    NR==2{
        printf "Total: %d MB\nUsed: %d MB\nFree: %d MB\nUsage: %.2f%%\n", $2, $3, $4, ($3/$2)*100
    }'
}

cpu_summary() {
    echo -e "${CYAN}---- CPU Summary ----${RESET}"
    top -b -n1 | grep "Cpu(s)" | awk '{print "User:", $2 "%  System:", $4 "%  Idle:", $8 "%"}'
}

top5_cpu_processes() {
    echo -e "${CYAN}---- Top 5 CPU Processes ----${RESET}"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -6
}

top5_memory_processes() {
    echo -e "${CYAN}---- Top 5 Memory Processes ----${RESET}"
    ps -eo pid,comm,%mem --sort=-%mem | head -6
}

network_interfaces() {
    echo -e "${CYAN}---- Network Interfaces ----${RESET}"
    ip -brief address
}

disk_usage_percent() {
    echo -e "${CYAN}---- Disk Usage Percentage ----${RESET}"
    df -h | awk '{print $1, $5}'
}

############################################
# COMPLEX FUNCTIONS
############################################

cpu_health_check() {
    echo -e "${BLUE}---- CPU Health Check ----${RESET}"
    cpu_idle=$(top -b -n1 | grep "Cpu(s)" | awk '{print $8}')
    cpu_used=$(echo "100 - $cpu_idle" | bc)

    echo -e "CPU Used: ${YELLOW}$cpu_used%${RESET}"

    if (( $(echo "$cpu_used > 80" | bc -l) )); then
        echo -e "Status: ${RED}CRITICAL${RESET}"
    elif (( $(echo "$cpu_used > 50" | bc -l) )); then
        echo -e "Status: ${YELLOW}WARNING${RESET}"
    else
        echo -e "Status: ${GREEN}HEALTHY${RESET}"
    fi
}

memory_health_check() {
    echo -e "${BLUE}---- Memory Health Check ----${RESET}"
    read total used free <<< $(free -m | awk 'NR==2{print $2, $3, $4}')
    usage=$(echo "scale=2; ($used/$total)*100" | bc)

    echo -e "Memory Usage: ${YELLOW}$usage%${RESET}"

    if (( $(echo "$usage > 80" | bc -l) )); then
        echo -e "Status: ${RED}CRITICAL${RESET}"
    elif (( $(echo "$usage > 60" | bc -l) )); then
        echo -e "Status: ${YELLOW}WARNING${RESET}"
    else
        echo -e "Status: ${GREEN}HEALTHY${RESET}"
    fi
}

system_bottleneck_detector() {
    echo -e "${BLUE}---- System Bottleneck Detector ----${RESET}"
    cpu_idle=$(top -b -n1 | grep "Cpu(s)" | awk '{print $8}')
    mem_free=$(free -m | awk 'NR==2{print $4}')
    io_wait=$(top -b -n1 | grep "Cpu(s)" | awk '{print $10}')

    echo "CPU Idle: $cpu_idle%"
    echo "Free Memory: $mem_free MB"
    echo "IO Wait: $io_wait%"

    if (( $(echo "$cpu_idle < 20" | bc -l) )); then
        echo "Bottleneck: CPU"
    elif [ "$mem_free" -lt 500 ]; then
        echo "Bottleneck: MEMORY"
    elif (( $(echo "$io_wait > 20" | bc -l) )); then
        echo "Bottleneck: DISK IO"
    else
        echo "Bottleneck: NONE"
    fi
}

network_health_check() {
    echo -e "${BLUE}---- Network Health Check ----${RESET}"
    active=$(ss -ant | grep ESTAB | wc -l)
    waiting=$(ss -ant | grep TIME-WAIT | wc -l)

    echo "Established Connections: $active"
    echo "Waiting Connections: $waiting"

    if [ "$active" -gt 100 ]; then
        echo -e "Status: ${YELLOW}HIGH LOAD${RESET}"
    else
        echo -e "Status: ${GREEN}NORMAL${RESET}"
    fi
}

long_running_processes() {
    echo -e "${BLUE}---- Long Running Processes (>1 hour) ----${RESET}"
    ps -eo pid,etime,comm | awk '
    {
        split($2,t,":");
        if(t[1] >= 60){ print }
    }'
}

############################################
# HARDWARE SAFE FUNCTIONS (NO DEPENDENCIES)
############################################

cpu_temperature() {
    echo -e "${BLUE}---- CPU Temperature ----${RESET}"
    if [ -f /sys/class/thermal/thermal_zone0/temp ]; then
        temp=$(cat /sys/class/thermal/thermal_zone0/temp)
        echo "Temperature: $(echo "scale=1; $temp/1000" | bc) °C"
    else
        echo "Temperature not available"
    fi
}

cpu_clock_speed() {
    echo -e "${BLUE}---- CPU Clock Speed ----${RESET}"
    if [ -f /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq ]; then
        freq=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq)
        echo "CPU Frequency: $(echo "scale=2; $freq/1000" | bc) MHz"
    else
        echo "CPU frequency info not available"
    fi
}

############################################
# MENU
############################################

show_menu() {
    echo -e "${CYAN}--------------------------------------${RESET}"
    echo -e "${CYAN}        SYSTEM MONITOR MENU            ${RESET}"
    echo -e "${CYAN}--------------------------------------${RESET}"

    echo "1. Show Running Processes"
    echo "2. Show Kernel Info"
    echo "3. Show Disk Usage"
    echo "4. Show System Uptime"

    echo "5. Memory Summary"
    echo "6. CPU Summary"
    echo "7. Top 5 CPU Processes"
    echo "8. Top 5 Memory Processes"
    echo "9. Network Interfaces"
    echo "10. Disk Usage Percentage"

    echo "11. CPU Health Check"
    echo "12. Memory Health Check"
    echo "13. System Bottleneck Detector"
    echo "14. Network Health Check"
    echo "15. Long Running Processes"

    echo "16. CPU Temperature"
    echo "17. CPU Clock Speed"

    echo "0. Exit"
    echo -e "${CYAN}--------------------------------------${RESET}"
}

############################################
# MAIN LOOP
############################################

while true; do
    show_menu
    read -p "Enter choice: " choice

    case $choice in
        1) show_processes ;;
        2) show_kernel ;;
        3) show_disk_usage ;;
        4) show_uptime ;;

        5) memory_summary ;;
        6) cpu_summary ;;
        7) top5_cpu_processes ;;
        8) top5_memory_processes ;;
        9) network_interfaces ;;
        10) disk_usage_percent ;;

        11) cpu_health_check ;;
        12) memory_health_check ;;
        13) system_bottleneck_detector ;;
        14) network_health_check ;;
        15) long_running_processes ;;

        16) cpu_temperature ;;
        17) cpu_clock_speed ;;

        0) echo "Exiting..."; break ;;
        *) echo "Invalid choice" ;;
    esac

    echo ""
    read -p "Press Enter to continue..."
    clear
done
