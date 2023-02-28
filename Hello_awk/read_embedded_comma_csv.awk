# run example:  gawk -f read_embedded_comma_csv.awk example_endpoints.csv

BEGIN {
    # FPAT = "([^,]+)|(\"[^\"]+\")"
    # As written above, the regexp used for FPAT requires that each field contain at least one character.
    # A straightforward modification (changing the first ‘+’ to ‘*’) allows fields to be empty:
    FPAT = "([^,]*)|(\"[^\"]+\")"

    # counter of omitted endpoints (have value 2 in 4th column)
    #omitted = 0
    omitted_core = 0

    print "\nOmitted endpoints:"
}

{
    # this part goes through every line of the input file one at the time
    #if ($4 == 2) {
    if ($4 == 2 && $5 == "yes") {
        print $0
        print $1 > "endpoints_omit_2_core_r10.csv"
        #omitted++
        omitted_core++
    }
}

END {
    #print "\nNumber of omitted endpoints: " omitted "\n"
    print "\nNumber of omitted core endpoints: " omitted_core "\n"
}