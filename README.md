# gene_expression

Utilities for a project on gene expression analysis and visualization

This utility will plot data in GSE12290.txt available from 
[The NCBI Gene Expression Omnibus](http://www.ncbi.nlm.nih.gov/geo/).
For further information about this data, see the series description for
"Age-related behaviors have distinct transcriptional profiles in C. elegans"

The gene plots contain the expression by the days of age.
The values for each individual are plotted for each age group, along with the
mean and the standard error of the mean.  The gene plots available are
provided only for data with no missing values.  There are some data in the
original dataset that contain NA values.  If you require plots for these data,
please adapt the `melovGeneExpression.R` script for that purpose.


### Data Source

ftp://ftp.ncbi.nih.gov/pub/geo/DATA/supplementary/series/GSE12290/GSE12290.txt

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE12290

http://www.ncbi.nlm.nih.gov/geo/

http://www.ncbi.nlm.nih.gov/sites/entrez?db=PubMed&term=Melov%20S[Author]

http://www.ncbi.nlm.nih.gov/sites/entrez?db=gds&term=Melov%20S[Author]

### Windows Installation

(These are notes from 2008.)

Run the binary installers for Python-2.6 and R-2.8.0.  It may not be important,
but try to select options that will install everything (accept the default paths,
unless your server is quirky).

Then append to the system path, ie:
set PATH=%PATH%;C:\Python26;C:\PROGRA~1\R\R-2.8.0\bin

Actually, set the PATH through:
Start > Control Panel > System
[Advanced Tab][Environment Variables Button]
[System Variables Block][Select "Path"][Press "Edit" button] etc.

That should suffice to make python-2.6 and R-2.8.0 available anywhere on the system.

Configure IIS for python (and perl, etc.)
http://www.boutell.com/newfaq/creating/iiscgihowto.html
http://support.microsoft.com/default.aspx?scid=kb%3Ben-us%3B276494

In addition, configure IIS by adding the ISAPI mappings for GET,POST to:
.py -> C:\Python26\python.exe %s %s
.R -> C:\PROGRA~1\R\R-2.8.0\bin\Rscript.exe %s %s

