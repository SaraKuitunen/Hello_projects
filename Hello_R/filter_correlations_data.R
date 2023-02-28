# Filter correlations data for FR_FG Risteys R8

# To make importing correlations data to database faster, 
# filter _EXMORE and _EXALLC endpoints from correlations data because
# those endpoints are not used in the (FR_FG and FinnGen) Risteys R8 

# Usage:
# Rscript filter_correlations_data.R path_to_input_file path_to_output_file

library(dplyr)

args <- commandArgs(trailingOnly = TRUE)

if(length(args)  != 2) {
  stop("Path to input file and output file need to be provided")
} else {
  path_to_input <-  args[1]
  path_to_output <-  args[2]
}

input_correlations <- read.csv(path_to_input)

# filter endpoints that have "_EXMORE" or "_EXALLC" in the name.
# There is four columns with endpoint name because correlations are for endpoint 
# PAIRS and for some endpoints there is only PHENOTYPIC or GENOTYPIC data information
output_correlations <- filter(input_correlations, 
                                       !(grepl("_EXMORE|_EXALLC", endpoint_a) | 
                                           grepl("_EXMORE|_EXALLC", endpoint_b) |
                                           grepl("_EXMORE|_EXALLC", pheno1) |
                                           grepl("_EXMORE|_EXALLC", pheno2)
                                         )
                                       )
                                                                     
write.csv(output_correlations, file = path_to_output, row.names = FALSE)
                                                                     
#### END OF THE SCRIPT ####