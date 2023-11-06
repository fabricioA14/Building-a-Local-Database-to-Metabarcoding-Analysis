#!/bin/bash

# Minimum sequence length
min_length=100

# Input FASTA file
input_file="local_database.fasta"

# Output FASTA file
output_file="fishes_database_ncbi.fasta"

# Exclude sequences with a number of base pairs equal to or less than 100
awk -v min_length="$min_length" -v RS=">" -v ORS="" '
{
    sub("\n", " ")
    if (length($0) >= min_length) {
        print ">" $0 "\n"
    }
}
' "$input_file" > "$output_file"


# Exclude the intermediate file
rm -rf local_database.fasta