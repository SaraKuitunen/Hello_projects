
# Set OMIT=2 value for selected endpoints not to be imported to the Risteys DB:
# F5_SAD (because it's seasonal endpooint) and endpoints that have OMIT=2 value in endpoint control file

# run: gawk -f path_to/set_omit_value_for_selected_endpoints.awk finngen_R10_endpoint_core_noncore_1.0__added_omit2.csv

BEGIN {
    # define what are field in the input data
    FPAT = "([^,]*)|(\"[^\"]+\")"
    # define output field separator, otherwise default empty line will be used for modified rows
    OFS = ","
    endpoints = 0
}

{
    # if endpoint name matches with names of endpoints to be excluded, set their omit value in column 4 to 2
    # Cannot use regex for finding the endpoint because that would match also with endpoints with _EXALLC and _EXMORE suffix
    if ($1 =="F5_SAD" ||
        $1 =="C3_LIVER_INTRAHEPATIC3_BILE_DUCTS" ||
        $1 =="HLP_C3_ASTROCYTOMA" ||
        $1 =="HLP_C3_COLON_ADENO" ||
        $1 =="HLP_C3_COLON_SQUAM" ||
        $1 =="HLP_C3_GBM" ||
        $1 =="HLP_C3_GLIOMIX" ||
        $1 =="HLP_C3_MEDULLOBLASTOMA") {

        $4 = 2
        print "endpoint: " $1 ",omit value: " $4 "."

        endpoints++
    }

    # print every row to a new file
    print $0 > "finngen_R10_endpoint_core_noncore_1.0__added_omit2_myfix.csv"
}

END {
    print "\nNumber of endpoints with changed omit value: " endpoints "\n"
    print "Number of rows: " NR
}