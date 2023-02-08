There are more than a million nonprofit organizations in the United States. Together, they control billions of dollars in income and assets. But they attract little serious attention from journalists.

However, we have both the data and the tools to see what makes nonprofits tick -- data from <code>IRS Form 990</code> and the tools in software such as <code>R</code> and <code>Python</code>.

R, which we'll be using in this class, can clean, analyze and visualze vast amounts of data efficiently. Its power comes from the thousands of packages that programmers and scientists have created to extend it. 

In R, packages first must be installed and then loaded. In this "bring your own laptop" class, you can load and install the necessary packages at the start or just watch and install them later. But here for future reference is how to install a package:

> install.packages("xxx")  [where "xxx" is the name of a package]

To load a package for use, simply enter this at the prompt:

> library(xxx) [where xxx is the name of the package -- and notice, this time the package name is NOT in quotes]

A few more points before we dig in:

* Capitalization matters. If a variable is spelled "Cat", don't write "cat" or "CAT". 
* Punctuation matters. R will help you by creating parentheses in pairs; don't erase closing parentheses by mistake.
* Assign variables with this mark, <code><-</code> (left arrow and hyphen). The shortcut on Windows is Alt + minus sign; on Mac it is Option + minus sign.
* Separate two or more steps of a command with this mark, <code>%>%</code>. The shortcut on Windows is Ctrl + Shift + M; on Mac it is Command + Shift + M. It can be read as "after that, do this."
* Comment out a line with the <code>#</code> (hash) mark
* Finally, you can create a script in R. This Is A Big Deal. It means you can insert comments in your code. It means you can recheck every stage of your work. It means that if you get fresh data you can import that data and recycle your old script using the new data to see if the results change.

In the script I've prepared, and which you can keep, you'll see that I try to be organized. (It's probably because, by nature, I'm the exact opposite.) Anyway, here are the steps:

1. Load packages.
2. Import data.
3. Clean data (if necessary -- it usually is).
4. Analyze and visualize data.
5. Publish data.

So let's load some libraries! If you haven't already installed the packages, do so now. 

> library(tidyverse)
  
> library(httr)
  
> library(readxl)
  
> library(lubridate)
  
> library(XML)
  
> library(xml2)
  
Some of the data files are quite large -- dozens or even hundreds of megabytes in size, and much too large to use in a class. But you might find them useful. So I'll provide demo scripts here along with links that you can use later. I'll also include some smaller files that we can download and analyze in class.
  
The IRS has several useful files at [Tax Exempt Organization Search](https://www.irs.gov/charities-non-profits/tax-exempt-organization-search). For some odd reason, the files, all zipped, lack column headers. But no worries, I've written R scripts for importing, unzipping and adding column headers to the files.

First up: Publication 78, the IRS list of nonprofits that can take tax-deductible contributions. The complete file is about 90 MB.
  
```
temp1 <- tempfile()
download.file("https://apps.irs.gov/pub/epostcard/data-download-pub78.zip", temp1, 
              mode = "wb")
unzip(temp1,"data-download-pub78.txt") 
unlink(temp1)
Charities <- read_delim("data-download-pub78.txt", delim="|", skip = 2, 
                        col_names = FALSE)
  ```

This will import about 1.2 million records into an R dataframe called Charities. Initially there will be six columns named "X1", "X2", etc. We fix that with the next command.
  
```
colnames(Charities)[1] <- 'EIN'
colnames(Charities)[2] <- 'Organization'
colnames(Charities)[3] <- 'City'
colnames(Charities)[4] <- 'State'
colnames(Charities)[5] <- 'Country'
colnames(Charities)[6] <- 'Type'
  ```

You now have a desktop reference you can use anytime a group says it's a charity that can take tax-deductible contributions. Either it's on this list (assuming you have the latest version), or it's not. Caveat: Churches do not need IRS approval.
  
Next: Nonprofits that lose their tax-exempt status by failing to file for three consecutive years. The complete file is 120 MB.
  
```
temp2 <- tempfile()
download.file("https://apps.irs.gov/pub/epostcard/data-download-revocation.zip", 
              temp2, mode = "wb")
unzip(temp2, "data-download-revocation.txt")
unlink(temp2)
Revoked <- read_delim("data-download-revocation.txt", delim = "|", skip = 2,
                      col_names = FALSE)
```
  
This will import about 1 million records into an R dataframe called Revoked. Initially there will be 12 columns called "X1", "X2", etc. Again, we use the colnames() command to fix that.
  
```
colnames(Revoked)[1] <- 'EIN'
colnames(Revoked)[2] <- 'Organization'
colnames(Revoked)[3] <- 'OrgSuffix'
colnames(Revoked)[4] <- 'Address'
colnames(Revoked)[5] <- 'City'
colnames(Revoked)[6] <- 'State'
colnames(Revoked)[7] <- 'ZIP'
colnames(Revoked)[8] <- 'Country'
colnames(Revoked)[9] <- 'Exempt'
colnames(Revoked)[10] <- 'Date1'
colnames(Revoked)[11] <- 'Date2'
colnames(Revoked)[12] <- 'Date3'
```
  
R imported the date fields in character format. They'll be much more useful formatted as true dates, which we can accomplish with the lubridate package, loaded earlier.
  
```
Revoked <- Revoked %>% 
  mutate(Date1 = dmy(Date1),
         Date2 = dmy(Date2),
         Date3 = dmy(Date3))
```
  
Like the Charities file, the Revoked filed is a useful reference to keep. Never know when you might find someone raising money for an organization that lost its tax-exempt status!
  
Nearly 1.3 million nonprofits file the e-Postcard, an electronic form that essentially tells the IRS -- and the public -- that they still exist and that their annual revenues are $50,000 or less. The e-Postcard dataset is fairly hefty, 236 MB, and only minimally informative, but it's the one uniform source of data on small nonprofits.
  
```
temp3 <- tempfile()
download.file("https://apps.irs.gov/pub/epostcard/data-download-epostcard.zip", 
              temp3, mode = "wb")
unzip(temp3, "data-download-epostcard.txt")
unlink(temp3)
Postcard <- read_delim("data-download-epostcard.txt", delim = "|", skip = 2,
                       col_names = FALSE)
```
  
The Postcard dataframe is 26 columns. The IRS provides little documentation to explain what's in any of those columns. I wasn't too surprised to discover that one column was blank. But I did figure out what all the others were and assigned them names.
  
```
colnames(Postcard)[1] <- 'EIN'
colnames(Postcard)[2] <- 'TaxYr'
colnames(Postcard)[3] <- 'Organization'
colnames(Postcard)[4] <- 'RevTest'
colnames(Postcard)[5] <- 'OutOfBiz'
colnames(Postcard)[6] <- 'FYBegin'
colnames(Postcard)[7] <- 'FYEnd'
colnames(Postcard)[8] <- 'Website'
colnames(Postcard)[9] <- 'Officer'
colnames(Postcard)[10] <- 'Address'
colnames(Postcard)[11] <- 'AddrSuffix'
colnames(Postcard)[12] <- 'City'
colnames(Postcard)[13] <- 'Blank1'
colnames(Postcard)[14] <- 'State'
colnames(Postcard)[15] <- 'Zip'
colnames(Postcard)[16] <- 'Country'
colnames(Postcard)[17] <- 'Address2'
colnames(Postcard)[18] <- 'AddressSuffix2'
colnames(Postcard)[19] <- 'City2'
colnames(Postcard)[20] <- 'State2a'
colnames(Postcard)[21] <- 'State2'
colnames(Postcard)[22] <- 'Zip2'
colnames(Postcard)[23] <- 'Country2'
colnames(Postcard)[24] <- 'DBA'
colnames(Postcard)[25] <- 'DBA2'
colnames(Postcard)[26] <- 'DBA3'
```

The Charities dataframe captures only those nonprofits that can accept tax-deductible nonprofits. There are many more tax-exempt groups that cannot accept deductible contributions, for example trade groups and organizations engaged in lobbying. To get the full range of the nonprofit world, we need the [Exempt Organization Business Master File](https://www.irs.gov/charities-non-profits/exempt-organizations-business-master-file-extract-eo-bmf). 
  
You can download the Business Master File for an individual state or in four comma-separated variable (CSV) files covering multi-state regions. When merged, the file is about 325 MB. Be sure to specify the column types, in particular for the first column, EIN, which must be formatted as character since it often contains leading zeroes. 
  

  
  
 
  
  
