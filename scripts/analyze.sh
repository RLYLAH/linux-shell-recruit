#!/usr/bin/env bash

# Task 07: complete this script.
# Usage: ./scripts/analyze.sh FILE

# TODO: validate arguments
# TODO: validate file existence
# TODO: print:
# Total ERROR: <number>
# Top Code: <code>
#!/usr/bin/env bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 FILE"
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "Error: File '$1' not found."
    exit 1
fi

total_error=$(grep -c "ERROR" "$1")
top_code=$(grep "ERROR" "$1" | grep -o "code=[0-9]*" | cut -d'=' -f2 | sort | uniq -c | sort -nr | head -n1 | awk '{print $2}')

echo "Total ERROR: $total_error"
echo "Top Code: $top_code"
exit 0
