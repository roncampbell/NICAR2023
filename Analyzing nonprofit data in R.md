There are more than a million nonprofit organizations in the United States. Together, they control billions of dollars in income and assets. But they attract too little attention from journalists.

However, we have both the data and the tools to see what makes nonprofits tick -- data from <code>IRS Form 990</code> and tools in software such as <code>R</code> and <code>Python</code>.

R, which we'll be using in this class, can clean, analyze and visualze vast amounts of data efficiently. Its power comes from the thousands of packages that programmers and scientists have created to extend it. 

This repository pulls together several resources for analyzing nonprofits -- links to key IRS and nonprofit websites, a table of Form 990 versions and schedules, a script (IRS reference.R) to get useful reference data like the list of tax-exempt data, and more scripts showing how to analyze bulk IRS data and statistical tables.

But first, a few starter tips:

In R, packages must be installed and then loaded. In this "bring your own laptop" class, you can load and install the necessary packages at the start or just watch and install them later. For future reference is how to install a package:

> install.packages("xxx")  [where "xxx" is the name of a package]

To load a package for use, simply enter this at the prompt:

> library(xxx) [where xxx is the name of the package -- and notice, this time the package name is NOT in quotes]

A few more points before we dig in:

* Capitalization matters. If a variable is spelled "Cat", don't write "cat" or "CAT". 
* Punctuation matters. R will help you by creating parentheses in pairs; don't erase closing parentheses by mistake.
* Assign variables with this mark, <code><-</code> (left arrow and hyphen). The shortcut on Windows is Alt + minus sign; on Mac it is Option + minus sign.
* Separate two or more steps of a command with this mark, <code>%>%</code>. The shortcut on Windows is Ctrl + Shift + M; on Mac it is Command + Shift + M. It can be read as "after that, do this."
* Comment out a line with the <code>#</code> (hash) mark

We'll be using these libraries: tidyverse, httr, readxl, lubridate, XML and xml2. If you haven't already installed them, you'll need to do so before loading them for the class.
  
In this class, I'm going to teach using smaller files while providing you with scripts that use much larger files - files that probably would break the conference wifi. 
  

  

  
  
 
  
  
