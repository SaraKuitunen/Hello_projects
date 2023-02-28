# Find _EXALLC and _EXMORE endpoints that are core and not omitted from Risteys

# run: gawk -f find_endpoints_EXALLC_or_EXMORE_core_not_omit_2_r10.awk /Users/sarakuitunen/risteys_data/risteys_r10_data/risteys_FG_r10_data/finngen_R10_endpoint_core_noncore_1.0__added_omit2.csv

BEGIN {
    FPAT = "([^,]*)|(\"[^\"]+\")"
    endpoints = 0
}

{
    # find _EXALLC and _EXMORE endpoints that are core and are included in Risteys, i.e. not omit 2
    # do not include endpoints with omit value 2 because they are not imported to Risteys DB

    #if ($1 ~ /_EXALLC/ && $4 != 2 && $5 == "yes") {
    if ($1 ~/_EXMORE/ && $4 != 2 && $5 == "yes") {
        print $0
        #print $1 > "endpoints_EXALLC_core_not_omit_2_r10.csv"
        print $1 > "endpoints_EXMORE_core_not_omit_2_r10.csv"
        endpoints++
    }
}

END {
    print "\nNumber of omitted core endpoints: " endpoints "\n"
}