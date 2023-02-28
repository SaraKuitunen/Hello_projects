BEGIN {
    # FPAT = "([^,]+)|(\"[^\"]+\")"
    # As written above, the regexp used for FPAT requires that each field contain at least one character.
    # A straightforward modification (changing the first ‘+’ to ‘*’) allows fields to be empty:
    FPAT = "([^,]*)|(\"[^\"]+\")"
}

{
    print "NF = ", NF
    for (i = 1; i <= NF; i++) {
        printf("$%d = <%s>\n", i, $i)
    }
}