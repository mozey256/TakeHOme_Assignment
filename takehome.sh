#how many samples

bcftools query -l sample.vcf.gz  | wc -l

#how many variants

bcftools query -f '%ALT\n' sample.vcf.gz | wc -l


#zcat sample.vcf.gz | vcf-annotate --fill-type | grep -oP "TYPE=\w+" | sort | uniq -c

#How would you extract the chromosome, position, QualByDepth and
#RMSMappingQuality fields? Save the output to a tab-delimited file

bcftools query -f '%CHROM\t%POS[\t%QD;%MQ]\n' sample.vcf > cqproutput.vcf

#Extract data that belongs to chromosomes 2,4 and MT
awk '$1=="2" || $1=="4" || $1=="MT"' sample.vcf


#7Print out variants that do not belong to chr20:1-30000000

awk '$1 != "20" || ($1 == "chr20" && ($2 < 1 || $2 > 30000000)) {print $1, $2, $4, $5}' cvfsample.vcf > filtered_variants.vcf

#Extract variants that belong to SRR13107019

 bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\n' -s SRR13107019 sample.vcf > output.vcf 

#9.Filter out variants with a QualByDepth above 7
awk -F '\t' '{if ($6>=7) print $0}' cvfsample.vcf > 9output.vcf

# how many contigs

grep -c "^##contig" sample.vcf


#12. Extract data on the read depth of called variants for sample SRR13107018

bcftools querry -f '%DP\n' -s SRR13107018 cvfsample.vcf > 12output.vcf

#13. Extract data on the allele frequency of alternate alleles. Combine this data with the
#-chromosome and position of the alternate allele

bcftools query -f '%CHROM\t%POS\t%AF\n' sample.vcf >alleles.vcf

# THE SAM FILE 

#3. How many samples are in the file

grep -E '^@RG' sample.sam | awk '{print $2}' | awk -F ':' '{print $2}' | sort | uniq | wc -l

#4. How many alignments are in the file

samtools view -F 4 sample.sam | wc -l

#5. Get summary statistics for the alignments in the file

samtools flagstat sample.sam > sam5.sam

#6. Count the number of fields in the file
awk '{print NF}' sample.sam | sort -nu | wc -l  

#7. Print all lines in the file that have @SQ and sequence name tag beginning with NT_

grep "@SQ.*NT_" sample.sam 

#8. Print all lines in the file that have @RG and LB tag beginning with Solexa

grep "@RG.*LB:Solexa" sample.sam

#9.Extract primarily aligned sequences and save them in another file

awk '$1 !~ /^@/ && $2 == "99" || $2 == "83"' sample.sam > primarily_sequences.sam

#10. Extract alignments that map to chromosomes 1 and 3. Save the output in BAM
#format

awk '$1 !~ /^@/ && ($3 == "1" || $3 == "3")' sample.sam | samtools view -Sb - > alignments_chr1_3.bam

#11. How would you obtain unmapped reads from the file
samtools view -f 4 sample.sam > unmapped_reads.sam

#12. How many reads are aligned to chromosome 4
grep -c "^4\t" sample.sam

#13 


#14. Extract all optional fields of the file and save them in “optional_fields.txt”

awk '{for(i=11;i<=NF;i++) print $i}' sample.sam > optional_fields.txt











