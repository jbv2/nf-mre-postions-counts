## Load libraries
library("dplyr")

#starting args object to recieve arguments from command line
#solution taken from https://www.r-bloggers.com/passing-arguments-to-an-r-script-from-command-lines/
args = commandArgs(trailingOnly = T )
message("Voy a imprimir los archivos recibidos por R")
print(args)

# For Debbuging only
# Comentar estas líneas cuando el script pase a producción
#args[1] is the bed file
#args[1] <- "test/data/sample_76g_PASS.snps_per_mre.tmp.bed"
#args[2] is the target file (expected output file)
#args[2] <- "test/data/positions_in_mre.tsv"

## Define input and outputs
input_file <- args[1]
output_file <- args[2]

mre_intersections.df <- data.frame(read.table(file = input_file, sep = "\t", stringsAsFactors = FALSE, row.names = NULL, header = FALSE))

plus_strain.df <- mre_intersections.df %>% filter(V14=="+")
reverse_strain.df <- mre_intersections.df %>% filter(V14=="-")

pos_plus_strains <- data.frame(plus_strain.df[ ,2] - plus_strain.df[ ,10])
pos_reverse_strain <- data.frame(reverse_strain.df[ ,11] - reverse_strain.df[ ,2] + 1)

bed_info_plus <- data.frame(plus_strain.df[c(0,1:5) %>% c(0,9:12) %>% c(0,14)])
bed_info_reverse <- data.frame(reverse_strain.df[c(0,1:5) %>% c(0,9:12) %>% c(0,14)])

#Add mre-pos to pos_strains
plus <- cbind.data.frame(bed_info_plus, pos_plus_strains)
minus <- cbind.data.frame(bed_info_reverse, pos_reverse_strain)

#Add tittles
names(plus)[1] <- "Chr"
names(plus)[2] <- "Pos-SNP"
names(plus)[3]<- "ID"
names(plus)[4]<- "Ref"
names(plus)[5]<- "Alt"
names(plus)[6]<- "CHR"
names(plus)[7]<- "Start"
names(plus)[8]<- "End"
names(plus)[9]<- "Target_ID"
names(plus)[10]<- "Strand"
names(plus)[11]<- "Pos_in_MRE"
names(minus)[1] <- "Chr"
names(minus)[2] <- "Pos-SNP"
names(minus)[3]<- "ID"
names(minus)[4]<- "Ref"
names(minus)[5]<- "Alt"
names(minus)[6]<- "CHR"
names(minus)[7]<- "Start"
names(minus)[8]<- "End"
names(minus)[9]<- "Target_ID"
names(minus)[10]<- "Strand"
names(minus)[11]<- "Pos_in_MRE"

position_mre.df <- merge.data.frame(x = plus, y = minus, all = TRUE)

write.table(x = position_mre.df, file = output_file, sep = "\t", row.names = FALSE, quote = FALSE)
