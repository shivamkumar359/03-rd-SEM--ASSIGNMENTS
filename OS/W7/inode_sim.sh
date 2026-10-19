#!/bin/bash

# ==========================================================
# Assignment: Inode Simulation - Sector Cost Calculation
# Description: Calculates the sector cost for different
#              file sizes and determines the addressing method.
# ==========================================================

# System parameters
SECTOR_SIZE=512
DIRECT_POINTERS=12
MAX_DIRECT_SIZE=$((SECTOR_SIZE * DIRECT_POINTERS))

# Function to calculate sectors required for a file
calculate_sectors() {
    local bytes=$1

    # Round up to account for a partially occupied sector
    echo $(((bytes + SECTOR_SIZE - 1) / SECTOR_SIZE))
}

# Function to determine the addressing method
get_addressing_method() {
    local bytes=$1

    if (( bytes <= MAX_DIRECT_SIZE )); then
        echo "DIRECT ADDRESSING SUFFICIENT"
    else
        echo "INDIRECT ADDRESSING NEEDED"
    fi
}

# File sizes in bytes (using binary units)
KB=$((1024))
MB=$((1024 * 1024))
GB=$((1024 * 1024 * 1024))

# Display assignment information
echo
echo "=============================================================="
echo "          INODE SIMULATION - SECTOR COST CALCULATION"
echo "=============================================================="
echo
echo "Sector Size          : $SECTOR_SIZE bytes"
echo "Direct Pointers      : $DIRECT_POINTERS"
echo "Maximum Direct Size  : $MAX_DIRECT_SIZE bytes"
echo

# Print the table header
printf "%-12s | %-15s | %-15s | %-30s\n" \
    "File Size" "Byte Count" "Sector Count" "Addressing Method"

printf '%s\n' \
    "-------------+-----------------+-----------------+--------------------------------"

# File sizes to evaluate
file_sizes=("1 KB" "100 KB" "1 MB" "1 GB" "10 GB")
byte_counts=(
    "$KB"
    "$((100 * KB))"
    "$MB"
    "$GB"
    "$((10 * GB))"
)

# Calculate and display results
for i in "${!file_sizes[@]}"; do
    bytes=${byte_counts[$i]}

    sectors=$(calculate_sectors "$bytes")
    method=$(get_addressing_method "$bytes")

    printf "%-12s | %-15s | %-15s | %-30s\n" \
        "${file_sizes[$i]}" "$bytes" "$sectors" "$method"
done

# Display the conclusion
echo
echo "=============================================================="
echo "CONCLUSION"
echo "=============================================================="
echo "Direct addressing can handle files up to $MAX_DIRECT_SIZE bytes."
echo "Files exceeding this limit require indirect addressing."
echo "=============================================================="
echo
