#!/bin/bash

# Define the pattern you want to search for in the headers
pattern="UNVERIFIED"

# Input FASTA file
input_file="local_database_ncbi.fasta"

# Output FASTA file
output_file="local_database_ncbi_filter.fasta"

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

# Order the ncbi dataset
awk '/^>/{gsub(/^>[^ ]+ /, ">" (++n) "_"); gsub(/,|;/, "", $0); gsub(/ /, "_"); $0=substr($0,1,50)}{print}' local_database_ncbi_filter.fasta > ncbi_database.fasta

# Exclude the intermediate file
rm -rf local_database_ncbi_filter.fasta
