#!/usr/bin/env python

"""
A python script to plot gene expression data generated by
Simon Melov, Ph.D.  This utility will use the R-project for
statistical computing to analyze data and generate bar graphs
of gene expression as a function of C. elegans age (in days).
"""

from melovGeneLibrary import *
from myHTML import *
import cgi

# ------------------------------------------
# main

#cgi.test()

print_header("Melov Data: Gene Probes Selected")

try:
    form = cgi.FieldStorage()
    if form.has_key("geneset"):
        geneset = form["geneset"]
    else:
        raise ValueError, "The form has no geneset - please advise web administrator of this server error.\n"
    # Get all the plot files and the gene-oligo values
    plotFiles, genes, oligos = getAllPlotFiles()
    oligoValues = []
    if type(geneset) == type([]):
        # geneset is a list of MiniFieldStorage objects
        for oligo in geneset:
            oligoValues.append(oligo.value)
    else:
        # We probably have one oligo selected, so
        # geneset is a MiniFieldStorage object
        oligo = geneset
        oligoValues.append(oligo.value)
    oligoFiles = []
    for oligo in oligoValues:
        for f in plotFiles:
            if oligo in f:
                oligoFiles.append(f)
    # Create a .zip file of the requested .eps plot files
    zipCleanupFiles()
    zipFileName = zipCreateFile(oligoFiles)
    # Return a link to the plot file archive.
    zipFileLink = "/melovGeneExpression/zipFiles/" + os.path.basename(zipFileName)
    print_link(zipFileLink, os.path.basename(zipFileName))
    print_para("You will have about 6 hrs to download this file.")
    print_para("This .zip file contains the following encapsulated postscript (.eps) plot files:")
    print "<table>"
    for f in oligoFiles:
        print "<tr><td>%s</td></tr>" % f
    print "</table>"
except:
    print_para("Oops: exception in melovGeneExpression.py")
    print_para("Please advise web administrator of this server error.")
    print sys.exc_info()

print_footer()
sys.exit()
