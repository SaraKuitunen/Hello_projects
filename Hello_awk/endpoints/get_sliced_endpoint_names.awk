BEGIN {
    # define fields
    # FPAT = "([^,]+)|(\"[^\"]+\")"
    # As written above, the regexp used for FPAT requires that each field contain at least one character.
    # A straightforward modification (changing the first ‘+’ to ‘*’) allows fields to be empty:
    FPAT = "([^,]*)|(\"[^\"]+\")"
}

{
    # find the index where regular expression starts in endpoint name from column 1
    # match($1, /_EXALLC/)
    match($1, /_EXMORE/)

    # if regular expression was found, index is saved to RSTART, ofterwise RSTART=0
    if (RSTART !=0) {
        print $1
        # slice the endpoint name, take slice from the beginnig of the name until the beginning of the regular expression
        # redirect to file
            # > – the output-file is erased before the first output is written to it. Subsequent writes to the same output-file
            # do not erase output-file, but append to it. (This is different from how you use redirections in shell scripts.)
            # If output-file does not exist, it is created.
        print substr($1, 1 , RSTART - 1) > "endpoints_EXMORE_counterparts.csv"
    }
}

END {

}