#!/bin/sh

# 25th January 2021
# Modification of Gertjan Bisschop's script for running array job on server
# Extracting individuals using vcf-subset
# Need to first run 'sconda atsweeps'

# Grid Engine options (lines prefixed with #$)
#$ -N Vcf_subset_AT                                     # Name of job in 'wstat' list
#$ -V                                                   # Pass current environm>
#$ -cwd                                                 # Run file from current>
#$ -l h=c1                                              # Run array job on this>
#$ -o /data/hartfield/atsweeps/scripts/output/          # Folder for STDOUT print
#$ -e /data/hartfield/atsweeps/scripts/error/           # Folder for STDERR print

# Run vcf-subset
vcf-subset -c 991,1061,1158,5830,5836,6019,6023,6034,6040,6041,6076,6085,6087,6090,6100,6105,6122,6136,6188,6284,6413,7>
  
# Copy file back to head folder
rsync -avz /scratch/mfellbaum/Vcf_subset_AT.vcf  /data/hartfield/atsweeps/analyses/
  
# EOF