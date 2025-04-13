#!/bin/bash

# Set paths
MONTHLY_PDF_DIR="/volume1/web/web_leigh/pdfs/monthly"
MONTHLY_JSON="/volume1/web/web_leigh/pdfs/monthlyPdfs.json"
WEEKLY_PDF_DIR="/volume1/web/web_leigh/pdfs/weekly"
WEEKLY_JSON="/volume1/web/web_leigh/pdfs/weeklyPdfs.json"

# Get the current year and month
current_year=$(date +%Y)
current_month=$(date +%-m)  # Remove leading zero with `%-m`

# Array of month names
months=("january" "february" "march" "april" "may" "june" "july" "august" "september" "october" "november" "december")

# Function to delete old monthly PDFs
delete_old_monthly_pdfs() {
    # Find and delete PDFs with past months
    for ((i=0; i<current_month-1; i++)); do
        month=${months[i]}
        pdf_file="$MONTHLY_PDF_DIR/$month.pdf"
        if [[ -f $pdf_file ]]; then
            echo "Deleting old monthly PDF: $pdf_file"
            rm "$pdf_file"
        fi
    done
}

# Function to delete old weekly PDFs
delete_old_weekly_pdfs() {
    # Get the current date
    current_date=$(date +%Y-%m-%d)
    # Calculate the date 2 days ago
    two_days_ago=$(date -d "2 days ago" +%Y-%m-%d)

    # Find and delete PDFs older than 3 days
    for file in "$WEEKLY_PDF_DIR"/*.pdf; do
        if [[ -f $file ]]; then
            # Extract the date from the filename
            file_date=$(echo "$file" | grep -oP '\d{4}-\d{2}-\d{2}')
            if [[ "$file_date" < "$two_days_ago" ]]; then
                echo "Deleting old weekly PDF: $file"
                rm "$file"
            fi
        fi
    done
}

# Function to recreate the monthly JSON
recreate_monthly_json() {
    # Initialize JSON array
    monthly_json_array=()

    # Loop through the monthly PDF directory and add PDFs to the JSON array
    for month in "${months[@]}"; do
        pdf_file="$MONTHLY_PDF_DIR/$month.pdf"
        if [[ -f $pdf_file ]]; then
            monthly_json_array+=("\"pdfs/monthly/$month.pdf\"")
        fi
    done

    # Create the JSON file
    echo "{ \"monthly\": [ $(IFS=,; echo "${monthly_json_array[*]}") ] }" > "$MONTHLY_JSON"
}

# Function to recreate the weekly JSON
recreate_weekly_json() {
    # Initialize JSON array
    weekly_json_array=()

    # Loop through the weekly PDF directory and add PDFs to the JSON array
    for file in "$WEEKLY_PDF_DIR"/*.pdf; do
        if [[ -f $file ]]; then
            # Get the relative path for the JSON
            relative_path="pdfs/weekly/$(basename "$file")"
            weekly_json_array+=("\"$relative_path\"")
        fi
    done

    # Create the JSON file
    echo "{ \"weekly\": [ $(IFS=,; echo "${weekly_json_array[*]}") ] }" > "$WEEKLY_JSON"
}

# Run the functions
delete_old_monthly_pdfs
delete_old_weekly_pdfs
recreate_monthly_json
recreate_weekly_json

echo "Cleanup and JSON updates completed."