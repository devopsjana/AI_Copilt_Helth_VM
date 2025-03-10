# VM Health Check Script

This script analyzes the health of a virtual machine based on CPU, memory, and disk space utilization. The virtual machine is considered healthy if all three parameters are less than 60% utilized. If any of these parameters are more than 60% utilized, the script declares the health as not healthy.

## Features

- Checks CPU, memory, and disk space utilization.
- Declares the health status of the virtual machine based on these parameters.
- Provides an explanation for the health status when the `explain` argument is passed.

## Prerequisites

- The script is designed to run on Ubuntu virtual machines.
- Ensure you have `bc` installed for floating-point arithmetic. You can install it using:
  ```bash
  sudo apt-get install bc
  ```

## Usage

1. Make the script executable:
   ```bash
   chmod +x vm_health_check.sh
   ```

2. Run the script:
   ```bash
   ./vm_health_check.sh
   ```

3. To get an explanation for the health status, use the `explain` argument:
   ```bash
   ./vm_health_check.sh explain
   ```

## Example

### Checking Health Status

```bash
$ ./vm_health_check.sh
CPU Utilization: 20.5%
Memory Utilization: 34.2%
Disk Utilization: 45%
Health Status: Healthy
```

### Checking Health Status with Explanation

```bash
$ ./vm_health_check.sh explain
CPU Utilization: 70.4%
Memory Utilization: 65.2%
Disk Utilization: 75%
The virtual machine is Not Healthy because one or more of the following utilizations are above 60%:
- CPU Utilization is above 60%: 70.4%
- Memory Utilization is above 60%: 65.2%
- Disk Utilization is above 60%: 75%
```

## How It Works

1. The script executes the `check_utilization` function to gather CPU, memory, and disk utilization metrics.
2. It then compares these metrics against the 60% threshold to determine the health status.
3. If the `explain` argument is provided, the script explains the reason for the health status by listing which metrics exceeded the threshold.

## License

This project is licensed under the MIT License.
