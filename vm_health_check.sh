#!/bin/bash

# Function to check CPU, Memory, and Disk utilization
check_utilization() {
    cpu_utilization=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    memory_utilization=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    disk_utilization=$(df / | grep / | awk '{print $5}' | sed 's/%//g')

    echo "CPU Utilization: $cpu_utilization%"
    echo "Memory Utilization: $memory_utilization%"
    echo "Disk Utilization: $disk_utilization%"

    if (( $(echo "$cpu_utilization < 60" | bc -l) )) && (( $(echo "$memory_utilization < 60" | bc -l) )) && (( $(echo "$disk_utilization < 60" | bc -l) )); then
        health_status="Healthy"
    else
        health_status="Not Healthy"
    fi
}

# Function to explain the health status
explain_status() {
    if [[ $health_status == "Healthy" ]]; then
        echo "The virtual machine is Healthy because CPU, Memory, and Disk utilization are all below 60%."
    else
        echo "The virtual machine is Not Healthy because one or more of the following utilizations are above 60%:"
        if (( $(echo "$cpu_utilization > 60" | bc -l) )); then
            echo "- CPU Utilization is above 60%: $cpu_utilization%"
        fi
        if (( $(echo "$memory_utilization > 60" | bc -l) )); then
            echo "- Memory Utilization is above 60%: $memory_utilization%"
        fi
        if (( $(echo "$disk_utilization > 60" | bc -l) )); then
            echo "- Disk Utilization is above 60%: $disk_utilization%"
        fi
    fi
}

# Main script execution
check_utilization

if [[ $1 == "explain" ]]; then
    explain_status
else
    echo "Health Status: $health_status"
fi
