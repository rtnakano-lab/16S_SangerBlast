#! /bin/bash

# Shell script for 16S sanger seq results.
# BLASTs against rhizobia isolated at MPIPZ, rhizobia obtained from public stocks, and AtSphere root isolates.
# MultiFASTA file containing all sequencing results is required
#
# originally by
# Ryohei Thomas Nakano, 04.02.2017
# last modified: 10.02.2021
# nakano@mpipz.mpg.de

# usage
# ./blast_16S.sh [full path of data directory]
# (Example: ./blast_16S.sh /biodata/dep_psl/grp_psl/ThomasN/seq_results/11106756571-1
# 
# sequence data should be stored in the ${ID}.fasta file, where ${ID} is the name of your directory (the last part of your full path)


# paths
# path to the blast database
BLASTDB="/netscratch/dep_psl/grp_psl/ThomasN/blastdb"
# path to the directory you store all relevant scripts
script_dir="/biodata/dep_psl/grp_psl/ThomasN/scripts/16S_SagnerBlast"
# path to Rscript
R_PATH="/netscratch/dep_psl/grp_psl/ThomasN/tools/bin/bin"





# data preparation
data_path=${1}
ID=${data_path/*\/}

query=${data_path}/${ID}.fasta

# BLAST against public rhizobia
blastn -db ${BLASTDB}/rhizobia_2_16S_public.fasta -query ${query} -outfmt 6 -evalue 1e-100 -perc_identity 97 -out ${data_path}/blast_public.results.temp.txt
cat ${script_dir}/outfmt_6.header.txt ${data_path}/blast_public.results.temp.txt > ${data_path}/blast_public.results.txt
rm ${data_path}/blast_public.results.temp.txt

# BLAST agianst AtSphere Root isolate
blastn -db ${BLASTDB}/AtSPHERE_WGS_full.fasta -query ${query} -outfmt 6 -evalue 1e-100 -perc_identity 97 -out ${data_path}/blast_atsphere.results.temp.txt
cat ${script_dir}/outfmt_6.header.txt ${data_path}/blast_atsphere.results.temp.txt > ${data_path}/blast_atsphere.results.txt
rm ${data_path}/blast_atsphere.results.temp.txt

# BLAST agianst MPIPZ-rhizobia
blastn -db ${BLASTDB}/rhizobia_2_16S.fasta -query ${query} -outfmt 6 -evalue 1e-100 -perc_identity 97 -out ${data_path}/blast_rhizobia.results.temp.txt
cat ${script_dir}/outfmt_6.header.txt ${data_path}/blast_rhizobia.results.temp.txt > ${data_path}/blast_rhizobia.results.txt
rm ${data_path}/blast_rhizobia.results.temp.txt

# Implementing meta information about isolates
${R_PATH}/Rscript ${script_dir}/blast_result_merge.R ${data_path}

# Done
