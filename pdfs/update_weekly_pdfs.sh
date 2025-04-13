#!/bin/bash

# filepath: /Users/harryjoyce/Library/Mobile Documents/com~apple~CloudDocs/Development/web_leigh/update_weekly_pdfs.sh

# Define the paths
WEEKLY_FOLDER="./pdfs/weekly"
JSON_FILE="./pdfs/weeklyPdfs.json"

# Check if the weekly folder exists
if [ ! -d "$WEEKLY_FOLDER" ]; then
  echo "Weekly folder not found: $WEEKLY_FOLDER"
  exit 1
fi

# Find all PDF files in the weekly folder
PDF_FILES=$(find "$WEEKLY_FOLDER" -type f -name "*.pdf" | sort)

# Create a JSON array from the PDF file paths
JSON_ARRAY=$(printf '%s\n' "$PDF_FILES" | sed "s|^$WEEKLY_FOLDER/|\"pdfs/weekly/|;s|$|\"|" | paste -sd "," -)

# Write the updated JSON to the file
cat >"$JSON_FILE" <<EOL
{
  "weekly": [
    $JSON_ARRAY
  ]
}
EOL

echo "Updated $JSON_FILE with the following files:"
echo "$PDF_FILES"
