

This is the repository for an <code>R</code> class on analyzing nonprofit data, taught at the <code>NICAR Conference</code> in Nashville, March 4, 2023. 

The repo contains a number of important files, including: 
 - A tipsheet, Analyzing nonprofit data in *R.md*
 - Extracts from 990 data and from the IRS Business Master File
 - A data dictionary of the 990s, *21eofinextractdoc.xlsx*
 - Two R scripts
 - Links to helpful websites, within *Links.md*
 - A reference table of 990 forms and schedules, *Form 990.md*
 - A list of codes used in the Exempt Organization Business Master File, in *EO reference.pdf*
 - The codes used to classify nonprofit groups by their activity, *NTEE_Codes.csv*

## Local installation
These files are available at https://tinyurl.com/nonprofit23 .

People wanting to work with this data should have the latest versions of R and R Studio installed. You'll also want some R packages installed from within R: tidyverse, httr, readxl, and lubridate. You may wish to try to install them all at once with an R command like 
> install.packages(c("tidyverse", "httr", "readxl", "lubridate"))

Ubuntu users may need to prepare for the R libraries by installing some Ubuntu libraries, with something like:
> sudo apt-get install libcurl4-openssl-dev libfontconfig1-dev libharfbuzz-dev libfribidi-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev libxml2-dev

## Last-minute virtual setup
If you are unable to get things installed properly in time for the class, you may wish to try a hosted version of RStudio:
- Visit https://posit.cloud/
- You may find it fastest to create an account tied to your Google account
 - When you're in: New Project button in the top-right corner
 - New project from Git repository (*not* new RSTudio project)
 - Git repository of https://github.com/roncampbell/NICAR2023
-  In the command panel, paste in *install.packages(c("tidyverse", "httr", "readxl", "lubridate"))*     and hit Enter. This will take a minute.

