#!/bin/bash
# Author: Kishmanpreet Kaur
# Roll Number: 2601730397
# Purpose: Generate a system information report

echo "=========================================="
echo "       SYSTEM INFORMATION REPORT"
echo "=========================================="
echo "Name: Kishmanpreet Kaur"
echo "Roll Number: 2601730397"
echo "Date: $(date)"
echo ""

OS_TYPE=$(uname -s)

echo "CPU INFORMATION"

if [ "$OS_TYPE" = "Linux" ]; then
    if command -v lscpu >/dev/null 2>&1; then
        CPU_MODEL=$(lscpu | awk -F: '/Model name/ {gsub(/^[ \t]+/, "", $2); print $2; exit}')
        CPU_CORES=$(lscpu | awk -F: '/^CPU\(s\)/ {gsub(/^[ \t]+/, "", $2); print $2; exit}')
    elif [ -r /proc/cpuinfo ]; then
        CPU_MODEL=$(awk -F: '/model name/ {gsub(/^[ \t]+/, "", $2); print $2; exit}' /proc/cpuinfo)
        CPU_CORES=$(grep -c '^processor' /proc/cpuinfo)
    else
        CPU_MODEL="Not exposed by this environment"
        CPU_CORES="Not exposed by this environment"
    fi

    echo "CPU Model: ${CPU_MODEL:-Not available}"
    echo "CPU Cores: ${CPU_CORES:-Not available}"

    echo ""
    echo "MEMORY INFORMATION"
    free -h | awk 'NR==2 {print "Total Memory: " $2 "\nUsed Memory: " $3}'

elif [ "$OS_TYPE" = "Darwin" ]; then
    echo "CPU Model: $(sysctl -n machdep.cpu.brand_string)"
    echo "CPU Cores: $(sysctl -n hw.ncpu)"
    echo ""
    echo "MEMORY INFORMATION"
    TOTAL_BYTES=$(sysctl -n hw.memsize)
    awk -v total="$TOTAL_BYTES" '
    /^Pages free:/ {free=$3}
    /^Pages inactive:/ {inactive=$3}
    /^Pages speculative:/ {speculative=$3}
    END {
        used=total-(free+inactive+speculative)*16384
        printf "Total Memory: %.2f GiB\nUsed Memory: %.2f GiB\n", total/1073741824, used/1073741824
    }' < <(vm_stat)
else
    echo "CPU and memory information unavailable for this OS."
fi

echo ""
echo "TOP 3 PROCESSES BY CPU USAGE"
ps aux | sort -nrk 3 | head -3

echo ""
echo "=========================================="
echo "Report generated successfully."
echo "=========================================="
