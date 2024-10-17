#!/bin/bash

# Description:
# This script determines if a given date is a "work Friday" or an "off Friday"

# Define the reference off Friday date (October 11, 2024)
REFERENCE_OFF_FRIDAY="2024-10-11"

# Function to calculate the difference in days between two dates
days_diff() {
    local start_date=$(date -jf "%Y-%m-%d" "$1" +%s)
    local end_date=$(date -jf "%Y-%m-%d" "$2" +%s)
    echo $(( (start_date - end_date) / 86400 ))
}

# Prompt user to input a date in YYYY-MM-DD format
read -p "Please enter a date (YYYY-MM-DD): " input_date

# Validate the date format using regex
if ! [[ "$input_date" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
    echo "Invalid date format. Please enter a valid date in YYYY-MM-DD format."
    exit 1
fi

# Split the input date into year, month, and day
year="${input_date:0:4}"
month="${input_date:5:2}"
day="${input_date:8:2}"

# Basic validation of month and day ranges
if (( month < 1 || month > 12 || day < 1 || day > 31 )); then
    echo "Invalid date. Please enter a valid date."
    exit 1
fi

# Check for February and leap years
if [[ "$month" -eq 02 ]]; then
    if (( (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0) )); then
        if (( day > 29 )); then
            echo "Invalid date. Please enter a valid date."
            exit 1
        fi
    else
        if (( day > 28 )); then
            echo "Invalid date. Please enter a valid date."
            exit 1
        fi
    fi
fi

# Calculate the number of days difference between the input date and the reference off Friday
days_difference=$(days_diff "$input_date" "$REFERENCE_OFF_FRIDAY")

# Calculate the number of weeks
weeks_difference=$(( days_difference / 7 ))

# Determine if it's an off Friday or a work Friday
if (( weeks_difference % 2 == 0 )); then
    echo "The date $input_date is an off Friday."
else
    echo "The date $input_date is a work Friday."
fi
