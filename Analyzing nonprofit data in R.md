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

First up: Publication 78, the IRS list of nonprofits that can take tax-deductible contributions.
  
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
  
 
 
  
  
