#!/bin/bash

# filepath: /Users/harryjoyce/Library/Mobile Documents/com~apple~CloudDocs/Development/web_leigh/update_all_pdfs.sh

# Run the update_monthly_pdfs.sh script
echo "Running update_monthly_pdfs.sh..."
if ./pdfs/update_monthly_pdfs.sh; then
    echo "Monthly PDFs updated successfully."
else
    echo "Failed to update monthly PDFs."
    exit 1
fi

# Run the update_weekly_pdfs.sh script
echo "Running update_weekly_pdfs.sh..."
if ./pdfs/update_weekly_pdfs.sh; then
    echo "Weekly PDFs updated successfully."
else
    echo "Failed to update weekly PDFs."
    exit 1
fi

echo "All PDF updates completed successfully."
