# Resource Files
Benchmark generation pipeline data dependencies are downloaded in the jupyter notebooks.


__File list__
```
├── README.md
├── genome_stratifications
│   ├── GRCh37_SimpleRepeat_homopolymer_gt20_slop5.bed.gz
│   ├── GRCh37_SimpleRepeat_imperfecthomopolgt20_slop5.bed.gz
│   ├── GRCh38_SimpleRepeat_homopolymer_gt20_slop5.bed.gz
│   └── GRCh38_SimpleRepeat_imperfecthomopolgt20_slop5.bed.gz
├── human.b37.genome
└── human.b38.genome
```

Homopolymers and imperfect homopolymers > 20 bp stratifications are part genome stratifications v2.01. Stratifications included in repo until the v2.01 stratifications are released.

## human.b37.genome
```
wget -O human.b37.genome_temp https://raw.githubusercontent.com/arq5x/bedtools2/master/genomes/human.hg19.genome

sed 's/^chr//' human.b37.genome_temp | \
sed 's/^X/23/;s/^Y/24/;s/^MT/25/'| \
grep -Ev '^M|^[0-9][0-9]_|^[0-9]_|^[0-9]\||^[0-9][0-9]\||^Un|^HS'| sort -k1,1n -k2,2n | \
sed 's/^23/X/;s/^24/Y/;s/^25/MT/' | \
sed '/^$/d' > human.b37.genome

rm human.b37.genome_temp
```


## human.b38.genome
```
wget -O human.b38.genome_temp https://raw.githubusercontent.com/arq5x/bedtools2/master/genomes/human.hg38.genome

sed 's/^chr//' human.b38.genome_temp | \
grep -Ev '^MT' | \
sed 's/^X/23/;s/^Y/24/;s/^M/25/'| \
grep -Ev '^[0-9][0-9]_|^[0-9]_|^[0-9]\||^[0-9][0-9]\||^Un|^HS'| \
sort -k1,1n -k2,2n | \
sed 's/^23/X/;s/^24/Y/;s/^25/M/'| \
sed 's/^[a-zA-Z0-9_]/chr&/' > human.b38.genome

rm human.b38.genome_temp
```