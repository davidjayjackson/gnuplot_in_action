#!/bin/bash

# gawk script to calculate 14-day and 28-day moving averages
awk -F, '
BEGIN {
    OFS=","; # Output field separator as comma for CSV format
    print "Date,14-Day Moving Average,28-Day Moving Average"; # Print header
}
NR > 1 { # Skip the header row
    dates[NR-1] = $1; # Store dates
    opens14[NR-1] = $2; # Store open values for 14-day average
    opens28[NR-1] = $2; # Store open values for 28-day average
    sum14 += $2; # Add current open value to 14-day sum
    sum28 += $2; # Add current open value to 28-day sum
    count14++; # Increment 14-day count
    count28++; # Increment 28-day count

    # 14-day moving average calculations
    if (count14 > 14) {
        sum14 -= opens14[NR-15];
        count14 = 14;
    }
    if (count14 == 14) {
        avg14 = sum14 / 14;
    } else {
        avg14 = ""; # Empty string when average is not available
    }

    # 28-day moving average calculations
    if (count28 > 28) {
        sum28 -= opens28[NR-29];
        count28 = 28;
    }
    if (count28 == 28) {
        avg28 = sum28 / 28;
    } else {
        avg28 = ""; # Empty string when average is not available
    }

    # Print date, 14-day and 28-day averages
    if (NR > 28) { # Print averages only when enough data is available
        print dates[NR-28], avg14, avg28;
    }
}
' /path/to/your/ETTS.csv > /path/to/your/output.csv
