#!/bin/bash

# This script determines if we will be working on a friday or not

# Define the reference off Friday date (October 11, 2024)
REFERENCE_OFF_FRIDAY="2024-10-11"

# Function to calculate the difference in days between two dates
days_diff() {
    local date1=$(date -d "$1" +%s)
    local date2=$(date -d "$2" +%s)
    echo $(( (date1 - date2) / 86400 ))
}

# Check if a date is a valid input
if [[ -z "$1" ]]; then
    echo "Please provide a Friday date in YYYY-MM-DD format."
    exit 1
fi

# Check if the provided date is a valid Friday
input_day=$(date -d "$1" '+%u')

if [[ "$input_day" -ne 5 ]]; then
    echo "The date provided is not a Friday. Please enter a valid Friday date."
    exit 1
fi

# Calculate the number of days difference between the input date and the reference off Friday
days_difference=$(days_diff "$1" "$REFERENCE_OFF_FRIDAY")

# Calculate the number of weeks
weeks_difference=$(( days_difference / 7 ))

# Determine if it's an off Friday or a work Friday
if (( weeks_difference % 2 == 0 )); then
    echo "The date $1 is an off Friday."
else
    echo "The date $1 is a work Friday."
fi
