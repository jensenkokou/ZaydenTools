# Leave Request Date Validator for Tsheets

This script processes a user-defined date range, filters out weekends and U.S. federal holidays, and returns a list of valid workdays (weekdays only) within that range.

## Why Use This Script?

| Benefit                         | Description                                                                 |
|---------------------------------|-----------------------------------------------------------------------------|
| **Automation of Repetitive Tasks** | Saves time by automating the calculation of valid workdays, reducing errors.  |
| **Ensures Accuracy**            | Accurately excludes weekends and U.S. federal holidays for better leave management. |
| **Convenient and User-Friendly**| Simple input process; automatically generates valid workdays.                |
| **Promotes Consistency**        | Ensures fairness by using the same criteria for all leave requests.          |
| **Customizable**                | Easily modify for additional holidays. |
| **Scalable**                    | Handles date ranges of any length, from short vacations to extended absences. |

## How to Use

1. **Save the Script**: Save the script to your local machine as `leave_request.sh`.

2. **Make it Executable**: Run the following command to make the script executable:
   ```bash
   chmod +x leave_request.sh

3. **Run the Script: Execute the script by running:
```bash
./leave_request.sh


** Input Date Range: When prompted, input the date range in the format MM-DD-YYYY to MM-DD-YYYY.

Example
bash
Copy code
Enter the leave request date range (e.g., 08-21-2024 to 09-20-2024):
08-21-2024 to 09-20-2024
The script will then output a list of valid workdays, excluding weekends and federal holidays, within the specified range.
