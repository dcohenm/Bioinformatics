## Installation of Blast+ Tools
wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST

## Unzip the file:
tar xvfz ncbi-blast-2.9.0+-x64-linux.tar.gz

## Add the "bin" folder
export PATH="/PATH/TO/ncbi-blast-2.9.0+/bin":$PATH

## Installation of Entrez 
sh -c "$(wget -q https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/install-edirect.sh -O -)"

##  PATH environment configuration
echo "export PATH=\$HOME/edirect:\$PATH" >> $HOME/.bash_profile

## configure the PATH for the current terminal session
export PATH=${HOME}/edirect:${PATH}

## Obtaining the Query Sequence
efetch -db sequences -id B4PPT4 -format fasta > pura_droya.fna

## Creating the Blast Database
makeblastdb -in protein.faa -dbtype prot -parse_seqids

## Running Blast
blastp -db protein.faa -query pura_droya.faa -out blast_results_species.tab -evalue 1.0E-6 -outfmt 6 -max_target_seqs 1000
