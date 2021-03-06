import argparse
import subprocess

parser = argparse.ArgumentParser(description="Find overlap for each input gene by the given input file")
parser.add_argument('--input_benchmark', metavar="I", type=str, nargs="+", help="input benchmark or asm bed file")
parser.add_argument('--input_genes', metavar="I", type=str, nargs="+", help="input gene bed file")
parser.add_argument('--output', metavar="O", type=str, nargs="+", help="output file")
args = parser.parse_args()

benchmark_filename = args.input_benchmark[0]

f_input_genes = open(args.input_genes[0], "r")
f_input_genes_lines = f_input_genes.readlines()
f_out = open(args.output[0], "w+")

bases_covered_per_gene = []

for gene in f_input_genes_lines:
    gene = gene.strip("\n")
    # print(gene)
    tmf = open("temp_gene_file.bed", "w")
    tmf.write(gene)
    tmf.flush()
    tmf.close()
    covered_bases = subprocess.run("bedtools intersect -a temp_gene_file.bed -b " + benchmark_filename + " | sort -k1,1 -k2,2n - | bedtools merge -i stdin | awk '{sum+=$3-$2} END {print sum}'", 
                                    shell = True, capture_output=True, text=True).stdout.strip()
    if covered_bases != '':
        bases_covered_per_gene.append(covered_bases)
    else:
        bases_covered_per_gene.append('0')
    subprocess.run("rm temp_gene_file.bed", shell = True)

# print(bases_covered_per_gene)
for i in range(0, len(f_input_genes_lines)):
    line = f_input_genes_lines[i]
    if "#" in line:
        f_out.write(line)
        f_out.flush()
        continue     
    line_split = line.split("\t")
    start = int(line_split[1])
    end = int(line_split[2])
    gene_length = end - start
    coverage = bases_covered_per_gene[i]
    # print(coverage)
    # print(gene_length)
    coverage_percentage = float(coverage)/float(gene_length)
    to_write_out = line_split[0] + "\t" + line_split[1] + "\t" + line_split[2] + "\t" + line_split[3].strip() + "\t" + str(coverage) + "\t" + str(coverage_percentage) + "\n"
    f_out.write(to_write_out)
    f_out.flush()  

f_out.close()
f_input_genes.close()