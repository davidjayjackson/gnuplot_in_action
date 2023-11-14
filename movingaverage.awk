#!/bin/bash

# gawk script to calculate 14-day moving average
awk -F, '
BEGIN {
    OFS=","; # Output field separator as comma for CSV format
    print "Date,14-Day Moving Average"; # Print header
}
NR > 1 { # Skip the header row
    dates[NR-1] = $1; # Store dates
    opens[NR-1] = $2; # Store open values
    sum += $2; # Add current open value to sum
    count++; # Increment count
    if (count > 14) {
        # Remove the oldest value from sum and decrease count
        sum -= opens[NR-15];
        count = 14;
    }
    if (count == 14) {
        # Calculate and print the moving average
        print dates[NR-14], sum / 14;
    }
}
' /path/to/your/ETTS.csv > /path/to/your/output.csv
