#!/bin/bash

# get reads
for i in 2 3 4; do prefetch SRR1795263$i & done

for i in 2 3 4; do fasterq-dump -O /home/wtm3/twg/rnaseq SRR1795263$i.sra; done

gzip /home/wtm3/twg/rnaseq/reads/SRR*

# trim reads
for i in {2..4}
do trimmomatic \
PE \
-threads 8 \
-phred33 \
$HOME/twg/rnaseq/reads/SRR1795263"$i"_1.fastq.gz \
$HOME/twg/rnaseq/reads/SRR1795263"$i"_2.fastq.gz \
$HOME/twg/rnaseq/trimmomatic/SRR1795263"$i".left_paired.fastq.gz \
$HOME/twg/rnaseq/trimmomatic/SRR1795263"$i".left_unpaired.fastq.gz \
$HOME/twg/rnaseq/trimmomatic/SRR1795263"$i".right_paired.fastq.gz \
$HOME/twg/rnaseq/trimmomatic/SRR1795263"$i".right_unpaired.fastq.gz \
ILLUMINACLIP:$HOME/apps/miniconda3/envs/rnaseq/share/trimmomatic-0.39-2/adapters/TruSeq3-PE-2.fa:2:30:10 \
LEADING:3 \
TRAILING:3 \
SLIDINGWINDOW:4:15 \
MINLEN:36 &
done

# index ref
hisat2-build \
$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
$HOME/twg/rnaseq/index/GCA_026437365.1_fEucNew1.0.hap1_genomic

# map
hisat2 \
--phred33 \
--rna-strandness RF \
--novel-splicesite-outfile $HOME/twg/rnaseq/hisat2/splicesite.txt \
-S $HOME/twg/rnaseq/hisat2/accepted_hits.sam \
-p 40 \
-x $HOME/twg/rnaseq/index/GCA_026437365.1_fEucNew1.0.hap1_genomic \
-1 $HOME/twg/rnaseq/trimmomatic/SRR17952632.left_paired.fastq.gz,\
$HOME/twg/rnaseq/trimmomatic/SRR17952633.left_paired.fastq.gz,\
$HOME/twg/rnaseq/trimmomatic/SRR17952634.left_paired.fastq.gz \
-2 $HOME/twg/rnaseq/trimmomatic/SRR17952632.right_paired.fastq.gz,\
$HOME/twg/rnaseq/trimmomatic/SRR17952633.right_paired.fastq.gz,\
$HOME/twg/rnaseq/trimmomatic/SRR17952634.right_paired.fastq.gz

## 73805461 reads; of these:
##   73805461 (100.00%) were paired; of these:
##     4741936 (6.42%) aligned concordantly 0 times
##     53194303 (72.07%) aligned concordantly exactly 1 time
##     15869222 (21.50%) aligned concordantly >1 times
##     ----
##     4741936 pairs aligned concordantly 0 times; of these:
##       359101 (7.57%) aligned discordantly 1 time
##     ----
##     4382835 pairs aligned 0 times concordantly or discordantly; of these:
##       8765670 mates make up the pairs; of these:
##         5835551 (66.57%) aligned 0 times
##         2208441 (25.19%) aligned exactly 1 time
##         721678 (8.23%) aligned >1 times
## 96.05% overall alignment rate

# sort
samtools \
view \
-bS \
-o $HOME/twg/rnaseq/hisat2/accepted_hits.bam \
$HOME/twg/rnaseq/hisat2/accepted_hits.sam

samtools \
sort \
-o $HOME/twg/rnaseq/hisat2/accepted_hits.sorted.bam \
$HOME/twg/rnaseq/hisat2/accepted_hits.bam

# assemble
stringtie \
$HOME/twg/rnaseq/hisat2/accepted_hits.sorted.bam \
-o $HOME/twg/rnaseq/stringtie/transcripts.gtf \
-p 40 \
-v

# decode
gtf_genome_to_cdna_fasta.pl \
/Volumes/Tigrigobius/twg/rnaseq/stringtie/transcripts.gtf \
/Volumes/Tigrigobius/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
> /Volumes/Tigrigobius/twg/rnaseq/transdecoder/transcripts.fasta 

gtf_to_alignment_gff3.pl \
/Volumes/Tigrigobius/twg/rnaseq/stringtie/transcripts.gtf \
> /Volumes/Tigrigobius/twg/rnaseq/transdecoder/transcripts.gff3

TransDecoder.LongOrfs \
-t /Volumes/Tigrigobius/twg/rnaseq/transdecoder/transcripts.fasta

# optionally, identify peptides with homology to known proteins or domains
# BLASTp
wget https://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.fasta.gz

gunzip $HOME/twg/rnaseq/transdecoder/uniprot_sprot.fasta.gz

makeblastdb \
-dbtype prot \
-in $HOME/twg/rnaseq/transdecoder/uniprot_sprot.fasta \
-out $HOME/twg/rnaseq/transdecoder/swissprot

blastp \
-query $HOME/twg/rnaseq/transdecoder/transcripts.fasta.transdecoder_dir/longest_orfs.pep \
-db $HOME/twg/rnaseq/transdecoder/swissprot \
-max_target_seqs 1 \
-outfmt 6 \
-evalue 1e-5 \
-num_threads 48 \
> $HOME/twg/rnaseq/transdecoder/blastp.outfmt6

# Pfam
wget ftp://ftp.ebi.ac.uk/pub/databases/Pfam/current_release/Pfam-A.hmm.gz

gunzip $HOME/twg/rnaseq/transdecoder/Pfam-A.hmm.gz

hmmpress $HOME/twg/rnaseq/transdecoder/Pfam-A.hmm

hmmsearch \
--cpu 8 \
-E 1e-10 \
--domtblout $HOME/twg/rnaseq/transdecoder/pfam.domtblout \
$HOME/twg/rnaseq/transdecoder/Pfam-A.hmm \
$HOME/twg/rnaseq/transdecoder/transcripts.fasta.transdecoder_dir/longest_orfs.pep

TransDecoder.Predict \
-t /Volumes/Tigrigobius/twg/rnaseq/transdecoder/transcripts.fasta \
--retain_pfam_hits /Volumes/Tigrigobius/twg/rnaseq/transdecoder/pfam.domtblout \
--retain_blastp_hits /Volumes/Tigrigobius/twg/rnaseq/transdecoder/blastp.outfmt6

cdna_alignment_orf_to_genome_orf.pl \
/Volumes/Tigrigobius/twg/rnaseq/transdecoder/transcripts.fasta.transdecoder.gff3 \
/Volumes/Tigrigobius/twg/rnaseq/transdecoder/transcripts.gff3 \
/Volumes/Tigrigobius/twg/rnaseq/transdecoder/transcripts.fasta \
> /Volumes/Tigrigobius/twg/rnaseq/transdecoder/transcripts.fasta.transdecoder.genome.gff3

## Done.  44598 / 50478 transcript orfs could be propagated to the genome

## redo with only the single best orf per transcript (prioritized by homology then orf length)
cp \
-r \
/Volumes/Tigrigobius/twg/rnaseq/transdecoder/transcripts.fasta.transdecoder_dir \
/Volumes/Tigrigobius/twg/rnaseq/transdecoder/transcripts.fasta.transdecoder_dir_original

TransDecoder.Predict \
-t /Volumes/Tigrigobius/twg/rnaseq/transdecoder/transcripts.fasta \
--retain_pfam_hits /Volumes/Tigrigobius/twg/rnaseq/transdecoder/pfam.domtblout \
--retain_blastp_hits /Volumes/Tigrigobius/twg/rnaseq/transdecoder/blastp.outfmt6 \
--single_best_only

cdna_alignment_orf_to_genome_orf.pl \
/Volumes/Tigrigobius/twg/rnaseq/transdecoder/transcripts.fasta.transdecoder.gff3 \
/Volumes/Tigrigobius/twg/rnaseq/transdecoder/transcripts.gff3 \
/Volumes/Tigrigobius/twg/rnaseq/transdecoder/transcripts.fasta \
> /Volumes/Tigrigobius/twg/rnaseq/transdecoder/transcripts.fasta.transdecoder.genome.gff3

## Done.  38040 / 39454 transcript orfs could be propagated to the genome



# PANTHER scoring for GO enrichment analysis
cd $HOME/apps
wget http://data.pantherdb.org/ftp/panther_library/current_release/PANTHER18.0_hmmscoring.tgz
tar xvf PANTHER18.0_hmmscoring.tgz
mv $HOME/apps/target/famlib/rel/PANTHER18.0_altVersion/hmmscoring/PANTHER18.0 $HOME/apps

mkdir pantherScore2.2; cd pantherScore2.2
wget http://data.pantherdb.org/ftp/hmm_scoring/19.0/pantherScore2.2/LICENSE
wget http://data.pantherdb.org/ftp/hmm_scoring/19.0/pantherScore2.2/README.txt
mkdir lib; cd lib
wget http://data.pantherdb.org/ftp/hmm_scoring/19.0/pantherScore2.2/lib/Blast.pm
wget http://data.pantherdb.org/ftp/hmm_scoring/19.0/pantherScore2.2/lib/FamLibBuilder.pm
wget http://data.pantherdb.org/ftp/hmm_scoring/19.0/pantherScore2.2/lib/FamLibBuilder_build.pm
wget http://data.pantherdb.org/ftp/hmm_scoring/19.0/pantherScore2.2/lib/FamLibBuilder_prod.pm
wget http://data.pantherdb.org/ftp/hmm_scoring/19.0/pantherScore2.2/lib/FamLibEntry.pm
wget http://data.pantherdb.org/ftp/hmm_scoring/19.0/pantherScore2.2/lib/FamLibEntry_build.pm
wget http://data.pantherdb.org/ftp/hmm_scoring/19.0/pantherScore2.2/lib/FamLibEntry_prod.pm
wget http://data.pantherdb.org/ftp/hmm_scoring/19.0/pantherScore2.2/lib/FastaFile.pm
wget http://data.pantherdb.org/ftp/hmm_scoring/19.0/pantherScore2.2/lib/Hit.pm
wget http://data.pantherdb.org/ftp/hmm_scoring/19.0/pantherScore2.2/lib/Hsp.pm
cd ..
wget http://data.pantherdb.org/ftp/hmm_scoring/19.0/pantherScore2.2/panther.cshrc
wget http://data.pantherdb.org/ftp/hmm_scoring/19.0/pantherScore2.2/pantherScore2.2.pl
wget http://data.pantherdb.org/ftp/hmm_scoring/19.0/pantherScore2.2/test.fasta

# for some reason this program only runs in the ~/apps/pantherScore2.2 directory
cd $HOME/apps/pantherScore2.2

seqkit \
split2 \
/Volumes/Tigrigobius/twg/rnaseq/transdecoder/transcripts.fasta.transdecoder.pep \
-s 100

/home/wtm3/twg/scripts/pantherScore.sh




# SnpEff
gff3_gene_to_gtf_format.pl \
/Volumes/Tigrigobius/twg/rnaseq/transdecoder/transcripts.fasta.transdecoder.genome.gff3 \
/Volumes/Tigrigobius/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
> /Volumes/Tigrigobius/twg/rnaseq/transdecoder/transcripts.fasta.transdecoder.genome.gtf

cp \
$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
$HOME/snpEff/data/genomes/fEucNew1.0.hap1.fa

scp \
/Volumes/Tigrigobius/twg/rnaseq/transdecoder/transcripts.fasta.transdecoder.genome.gtf \
wtm3@bio-server02.humboldt.edu:/home/wtm3/snpEff/data/fEucNew1.0.hap1/genes.gtf

cp $HOME/twg/rnaseq/transdecoder/transcripts.fasta.transdecoder.cds $HOME/snpEff/data/fEucNew1.0.hap1/cds.fa
cp $HOME/twg/rnaseq/transdecoder/transcripts.fasta.transdecoder.pep $HOME/snpEff/data/fEucNew1.0.hap1/protein.fa

cd $HOME/snpEff

java -Xmx20g -jar snpEff.jar build -gtf22 -v fEucNew1.0.hap1 2>&1 | tee fEucNew1.0.hap1.build

gunzip $HOME/tgoby/vcf/phased/segregating_sites.recode.vcf.gz

java -Xmx20g -jar snpEff.jar fEucNew1.0.hap1 $HOME/tgoby/vcf/phased/segregating_sites.recode.vcf > $HOME/tgoby/vcf/phased/segregating_sites.recode.ann.vcf

bgzip $HOME/tgoby/vcf/phased/segregating_sites.recode.ann.vcf &&
tabix $HOME/tgoby/vcf/phased/segregating_sites.recode.ann.vcf.gz

bgzip $HOME/tgoby/vcf/phased/segregating_sites.recode.vcf


java -Xmx20g -jar SnpSift.jar filter "ANN[*].EFFECT has 'synonymous_variant'" $HOME/tgoby/vcf/phased/segregating_sites.recode.ann.vcf.gz > $HOME/tgoby/vcf/phased/synonymous_variant.vcf.gz
