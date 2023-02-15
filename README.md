
This is the repository for an <code>R</code> class on analyzing nonprofit data, taught at the <code>NICAR Conference</code> in Nashville, March 4, 2023. 

The repo contains a number of important files, including: 
 - A tipsheet, Analyzing nonprofit data in *R.md*
 - Extracts from 990 data and from the IRS Business Master File
 - A data dictionary of the 990s, *21eofinextractdoc.xlsx*
 - Two R scripts
 - Links to helpful websites, within *Links.md*
 - A reference table of 990 forms and schedules, *Form 990.md*
 - A list of codes used in the Exempt Organization Business Master File, in *EO reference.pdf*

People wanting to work with this data should have the latest versions of R and R studio installed. You'll also want some R packages installed from within R: tidyverse, httr, readxl, and lubridate. You may wish to try to install them all at once with an R command like 
> install.packages(c("tidyverse", "httr", "readxl", "lubridate"))
