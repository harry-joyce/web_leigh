#!/bin/bash

# filepath: /Users/harryjoyce/Library/Mobile Documents/com~apple~CloudDocs/Development/web_leigh/update_monthly_pdfs.sh

# Define the paths
MONTHLY_FOLDER="./pdfs/monthly"
JSON_FILE="./pdfs/monthlyPdfs.json"

# Check if the monthly folder exists
if [ ! -d "$MONTHLY_FOLDER" ]; then
    echo "Monthly folder not found: $MONTHLY_FOLDER"
    exit 1
fi

# Find all PDF files in the monthly folder
PDF_FILES=$(find "$MONTHLY_FOLDER" -type f -name "*.pdf" | sort)

# Create a JSON array from the PDF file paths
JSON_ARRAY=$(printf '%s\n' "$PDF_FILES" | sed "s|^$MONTHLY_FOLDER/|\"pdfs/monthly/|;s|$|\"|" | paste -sd "," -)

# Write the updated JSON to the file
cat >"$JSON_FILE" <<EOL
{
  "monthly": [
    $JSON_ARRAY
  ]
}
EOL

echo "Updated $JSON_FILE with the following files:"
echo "$PDF_FILES"
