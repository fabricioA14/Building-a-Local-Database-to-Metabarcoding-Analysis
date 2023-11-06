#!/bin/bash

# Define the pattern you want to search for in the headers
pattern="SUPPRESSED"

# Input FASTA file
input_file="local_database_bold.fasta"

# Output FASTA file
output_file="local_database_bold_filter.fasta"

# Exclude all the sequences with the specified pattern in the headers
awk -v pattern="$pattern" -v output_file="$output_file" '
    /^>/ {
        if ($0 !~ pattern) {
            if (header) {
                print header
                print sequence
            }
            header = $0
            sequence = ""
        }
        next
    }
    {
        sequence = sequence $0
    }
    END {
        if (header) {
            print header
            print sequence
        }
    }
' "$input_file" > "$output_file"

# Order the bold database
sed -E 's/^>[^|]*\|([^|]*)\|.*/>\1/; s/ /_/g' local_database_bold_filter.fasta > bold_database.fasta

# Exclude the intermediate file
rm -rf local_database_bold_filter.fasta
