#!/bin/bash 

# This script processes a user-defined date range, filters out weekends and U.S. federal holidays and returns a list of valid workdays (weekdays only) within that range.

# Author: Jensen Kokou :)

# Define the static list of federal holidays
federal_holidays=(
    "01-01" # New Year’s Day
    "01-02" # Observed New Year’s Day
    "01-15" # Martin Luther King Jr Day
    "02-19" # Presidents’ Day
    "05-27" # Memorial Day
    "06-19" # Juneteenth
    "07-04" # Independence Day
    "09-02" # Labor Day
    "10-14" # Columbus Day
    "11-11" # Veterans Day
    "11-28" # Thanksgiving Day
    "12-25" # Christmas Day
)

# Function to check if a date is a weekend
is_weekend() {
    local date="$1"
    local day_of_week=$(date -j -f "%m-%d-%Y" "$date" +%u)
    if [ "$day_of_week" -gt 5 ]; then
        return 0
    else
        return 1
    fi
}

# Function to check if a date is a federal holiday
is_federal_holiday() {
    local date="$1"
    local date_no_year=$(date -j -f "%m-%d-%Y" "$date" +%m-%d)
    for holiday in "${federal_holidays[@]}"; do
        if [ "$date_no_year" == "$holiday" ]; then
            return 0
        fi
    done
    return 1
}

# Function to generate the dates within the range
generate_dates_in_range() {
    local start_date="$1"
    local end_date="$2"
    local current_date="$start_date"

    while [ "$(date -j -f "%m-%d-%Y" "$current_date" +%Y%m%d)" -le "$(date -j -f "%m-%d-%Y" "$end_date" +%Y%m%d)" ]; do
        echo "$current_date"
        current_date=$(date -j -v +1d -f "%m-%d-%Y" "$current_date" +%m-%d-%Y)
    done
}

# Read the leave request date range from the user
echo "Enter the leave request date range (e.g., 08-21-2024 to 09-20-2024):"
read start_date_str to end_date_str

# Convert the input to the proper date format
start_date=$(date -j -f "%m-%d-%Y" "$start_date_str" +%m-%d-%Y)
end_date=$(date -j -f "%m-%d-%Y" "$end_date_str" +%m-%d-%Y)

# Generate all dates in the range and filter out weekends and federal holidays
valid_leave_dates=()
for date in $(generate_dates_in_range "$start_date" "$end_date"); do
    if ! is_weekend "$date" && ! is_federal_holiday "$date"; then
        valid_leave_dates+=("$date")
    fi
done

# Output the valid leave dates
echo "Valid leave request dates (weekdays only, excluding federal holidays):"
for date in "${valid_leave_dates[@]}"; do
    echo "$date"
done
