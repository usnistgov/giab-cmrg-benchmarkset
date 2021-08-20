import argparse

parser = argparse.ArgumentParser(description="Remove loci that do not have correct Ref allele")
parser.add_argument('--input_vcf_file', metavar="I", type=str, nargs="+", help="input file")
parser.add_argument('--output_file', metavar="O", type=str, nargs="+", help="output file")
args = parser.parse_args()

vcf_file = open(args.input_vcf_file[0], "r")
output_file = open(args.output_file[0], "w+")

vcf_lines = vcf_file.readlines()

ref_allele_set = set(['A','G','C','T','N'])
for line in vcf_lines:
    if "#" in line:
        output_file.write(line)
        continue
    split_line = line.split("\t")
    ref_allele_to_test = set(split_line[3])
    if ref_allele_set.issuperset(ref_allele_to_test):
        if "*,*" not in split_line[4]:
            output_file.write(line)

vcf_file.close()
output_file.close()
