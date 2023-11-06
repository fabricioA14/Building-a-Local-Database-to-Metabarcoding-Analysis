#!/bin/bash

# Filter sequences with a number of base pairs equal to or less than 100
awk '/^>/ { if (seq_length >= 100) { print header; print seq; } header = $0; seq = ""; seq_length = 0; next; } { seq = seq $0; seq_length += gsub(/[ATGCatgc]/, ""); } END { if (seq_length >= 100) { print header; print seq; } }' local_database.fasta > local_database_trimmed.fasta

#Insert numbers before the beginning of each sequence header
awk '/^>/{sub(/^>/, ">" ++c "_");} 1' local_database_trimmed.fasta > local_database_bold.fasta

# Exclude the intermediate file
rm -rf local_database_trimmed.fasta