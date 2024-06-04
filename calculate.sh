#!/bin/bash

# Directory containing the files
BUILD_DIR="build"

# File patterns to match
PATTERNS=(
  "scrolling_timeline_global_keys_*.timeline_summary.json"
  "scrolling_timeline_no_keys_*.timeline_summary.json"
  "scrolling_timeline_value_keys_*.timeline_summary.json"
  "scrolling_timeline_slivers_prototype_*.timeline_summary.json"
  "scrolling_timeline_sliver_*.timeline_summary.json"
  "scrolling_timeline_shrink_wrap_*.timeline_summary.json"
  "scrolling_timeline_shrink_wrap_never_scrollable_*.timeline_summary.json"
)

# Function to calculate the average of a given field for a given pattern
calculate_average() {
  local pattern=$1
  local field=$2
  local total_value=0
  local file_count=0

  # Iterate over matching files
  for file in "$BUILD_DIR"/$pattern; do
    # Check if file exists
    if [[ -f "$file" ]]; then
      # Extract the value of the given field from the JSON file
      value=$(jq ".$field" "$file")
      
      # Add the value to the total
      total_value=$(echo "$total_value + $value" | bc)
      
      # Increment the file count
      ((file_count++))
    fi
  done

  # Calculate the average value
  if [[ $file_count -gt 0 ]]; then
    average_value=$(echo "scale=2; $total_value / $file_count" | bc)
    echo "$pattern: Average $field: $average_value"
  else
    echo "$pattern: No matching files found."
  fi
}

# Main script
if [[ $# -lt 1 ]]; then
  echo "Usage: $0 field_name [field_name ...]"
  exit 1
fi

# Iterate over each field provided as argument
for field in "$@"; do
  echo "Calculating averages for field: $field"
  for pattern in "${PATTERNS[@]}"; do
    calculate_average "$pattern" "$field"
  done
  echo
done
