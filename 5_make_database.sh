#!/bin/bash

#Make the local database
makeblastdb -in curated_database.fasta -parse_seqids -blastdb_version 5 -title COI_local_database -dbtype nucl

