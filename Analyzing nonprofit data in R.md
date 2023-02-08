There are more than a million nonprofit organizations in the United States. Together, they control billions of dollars in income and assets. But they attract too little attention from journalists.

We have both the data and the tools to see what makes nonprofits tick -- data from <code>IRS Form 990</code> and tools in software such as <code>R</code> and <code>Python</code>.

We'll be using R in this class. It can clean, analyze and visualze vast amounts of data efficiently. 

This repository pulls together several resources for analyzing nonprofits -- links to key IRS and nonprofit websites, a table of Form 990 versions and schedules, and a few scripts to import and analyze data.

The IRS provides four different windows into the nonprofit world:
**Reference information**, including employer identification numbers (EIN), organization names and addresses for every tax-exempt group; similar information for the tax-exempt groups that can accept tax-deductible contributions; and lists of groups that have lost their tax exemptions. In addition, every nonprofit with annual revenue under $50,000 is listed. For a script to download these files, see <code>IRS reference.R</code> in the Data folder.
**Financial information** on almost every nonprofit. For a script using an extract, see <code>IRS statistics.R</code> in the Data folder. 
**Complete 990s in digital (XML) format** (2015 to 2020).
**Complete 990s in PDF format** (2016 to July 2022). 

For those of you who are new to R or need a refresher, here are some tips:

In R, packages must be installed and then loaded. In this "bring your own laptop" class, you can load and install the necessary packages at the start or just watch and install them later. For future reference is how to install a package:

> install.packages("xxx")  [where "xxx" is the name of a package]

To load a package for use, simply enter this at the prompt:

> library(xxx) [where xxx is the name of the package -- and notice, this time the package name is NOT in quotes]

A few more points about R before we dig in:

* Capitalization matters. If a variable is spelled "Cat", don't write "cat" or "CAT". 
* Punctuation matters. R will help you by creating parentheses in pairs; don't erase closing parentheses by mistake.
* Assign variables with this mark, <code><-</code> (left arrow and hyphen). The shortcut on Windows is Alt + minus sign; on Mac it is Option + minus sign.
* Separate two or more steps of a command with this mark, <code>%>%</code>. The shortcut on Windows is Ctrl + Shift + M; on Mac it is Command + Shift + M. It can be read as "after that, do this."
* Comment out a line with the <code>#</code> (hash) mark

We'll be using these libraries: tidyverse, httr, readxl, lubridate, XML and xml2. If you haven't already installed them, you'll need to do so before loading them for the class.
