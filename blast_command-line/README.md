**NCBI Blast: How to Use Blast Tools from the Command Line**

NCBI Blast is a fundamental tool in bioinformatics used to compare biological sequences, such as DNA and proteins, and find similarities between them.

At times, you might need to use Blast on your own computer to query thousands of sequences against a custom database containing hundreds of thousands of sequences. To achieve this, you'll need to install Blast on your computer, index the database, and then perform sequence alignment.

This tutorial provides a basic introduction to installing and using NCBI Blast tools from the command line. With this capability, you'll be able to conduct more detailed and specific analyses of biological sequences, which is essential in molecular biology and genetics research.

**Installation of Blast+ Tools**

Obtain the compiled executables from this URL:

```bash
wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/
```

Unzip the file:

```bash
tar xvfz ncbi-blast-2.9.0+-x64-linux.tar.gz
```

Add the "bin" folder from the unzipped file to your path. Add the following line to your ~/.bashrc file:

```bash
export PATH="/PATH/TO/ncbi-blast-2.9.0+/bin":$PATH
```

Replace "/PATH/TO" with the path where you placed the unzipped file.

**Installation of Entrez Direct Tools**

[Entrez Direct (EDirect)](https://www.ncbi.nlm.nih.gov/books/NBK179288/) provides access to NCBI's interconnected database suite (publications, sequences, structures, genes, variations, expression, etc.) from a Unix terminal window. You don't need to install this tool if you're going to download files through other means.

To install EDirect software, open a terminal window and run one of the following two commands:
```bash
sh -c "$(wget -q https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/install-edirect.sh -O -)"
```
This will download various scripts and precompiled programs into an "edirect" folder in the user's home directory. It will then print an additional command to update the PATH environment variable in the user's configuration file:

```bash
echo "export PATH=\$HOME/edirect:\$PATH" >> $HOME/.bash_profile
```
Once the installation is complete, run:

```bash
export PATH=${HOME}/edirect:${PATH}
```
to configure the PATH for the current terminal session.

**Obtaining the Query Sequence**

We will perform a sequence alignment with a protein called Adenylosuccinate synthetase related to purine metabolism in Drosophila, with the accession number B4PPT4.

To do this, download the sequence using the previously installed Edirect:

```bash
efetch -db sequences -id B4PPT4 -format fasta > pura_droya.fna
```
**Parameters**
- **-db**: database name
- **-id**: query sequence accession number
- **-format**: output format

The data you'll use is located in the "data" folder of this tutorial:

- `pura_droya.faa`
- `protein.faa`

**Creating the Blast Database**

Different Blast tools require an indexed database for performing alignments. To create the database, we use the makeblastdb tool:

```bash
makeblastdb -in protein.faa -dbtype prot -parse_seqids
```
**Parameters**
- **-in**: multi-FASTA file of sequences
- **-dbtype**: database type
- **-parse_seqids**: option to parse sequence IDs for FASTA input if set.

This will create a list of files in the folder. All these files are part of the Blast database.

**Running Blast**

Now we can run Blast on our query sequence against the database. In this case, both our query sequence and the database sequences are amino acid sequences, so we'll use the blastp tool:

```bash
blastp -db protein.faa -query pura_droya.faa -out blast_results_species.tab -evalue 1.0E-6 -outfmt 6 -max_target_seqs 1000
```

Available Blast programs:

|Query Type|Database Type|BLAST Program|
|----|---|---|
|protein|proteins|**blastp**: compares a protein sequence to a protein sequence database.|
|nucleotide|nucleotides|**blastn**: compares a nucleotide sequence to a nucleotide sequence database.|
|nucleotide |proteins|**blastx**: compares the six-frame translation of a nucleotide sequence to a protein sequence database.|
|protein |nucleotides|**tblastn**: compares a protein sequence to the six-frame translation of a nucleotide sequence database.|
|nucleotide|nucleotides|**tblstx**: compares the six-frame translation of a nucleotide sequence to the six-frame translation of a nucleotide sequence database.|

**Snippet of Output:**

```
sp|B4PPT4.1|PURA_DROYA  NP_001117.2     52.834  494     167     9       18      505     22      455     2.73e-171      492
sp|B4PPT4.1|PURA_DROYA  NP_689541.1     58.311  379     152     4       131     505     80      456     1.95e-158      459
sp|B4PPT4.1|PURA_DROYA  NP_689541.1     72.519  131     33      1       24      151     31      161     6.40e-58       200
sp|B4PPT4.1|PURA_DROYA  NP_954634.1     58.311  379     152     4       131     505     123     499     2.66e-157      458
sp|B4PPT4.1|PURA_DROYA  NP_954634.1     68.687  99      28      1       57      152     107     205     2.95e-36       142
sp|B4PPT4.1|PURA_DROYA  XP_006720089.1  56.842  380     157     5       131     505     80      457     1.10e-150      439
sp|B4PPT4.1|PURA_DROYA  XP_006720089.1  68.182  132     38      2       24      151     31      162     1.47e-50       180
```

**More Information:**
Altschul SF, Gish W, Miller W, Myers EW, Lipman DJ. [Basic local alignment search tool](https://pubmed.ncbi.nlm.nih.gov/2231712/ "Basic local alignment search tool"). J Mol Biol. 1990 Oct 5;215(3):403-10. doi: 10.1016/S0022-2836(05)80360-2. PMID: 2231712.