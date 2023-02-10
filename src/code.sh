#!/bin/bash

# Runs vcf2maf.pl to produce individual MAF files with all mutation
# annotation. The app runs without VEP configurations using the
# --inhibit-vep argument since input files should be annotated with
# eggd_vep prior to using the app.


# -e = exit on error; -x = output each line that is executed to log; -o pipefail = throw an error if there's an error in pipeline
set -e -x -o pipefail

#Install dependencies from assets

# Download inputs from DNAnexus in parallel, to go into /home/dnanexus/in/
echo "download_inputs"
dx-download-all-inputs --parallel
echo "download_complete"
ls /home/dnanexus/in/input_vcf/
#run vcf2maf.pl for output MAF file
 perl vcf2maf.pl --input-vcf /home/dnanexus/in/input_vcf \
 --output-maf /home/dnanexus/out/ $output_maf \
 --inhibit-vep \
 --ref-fasta /home/dnanexus/in/ref_fasta
# Upload outputs (from /home/dnanexus/out) to DNAnexus
dx-upload-all-outputs --parallel
