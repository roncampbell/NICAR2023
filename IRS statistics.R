##################
# IRS statistics #
##################

# set working directory and load packages
setwd()
library(tidyverse)
library(readxl)

# financial info on most nonprofits is available at 
# https://www.irs.gov/statistics/soi-tax-stats-annual-extract-of-tax-exempt-organization-financial-data
# The organizations are identified by EIN (Employer Identification Number). 
# To get names and other identifying info, combine with Business Master File, imported in IRS reference.R.

# The 2021 files range in size from 377 MB for 990s to 95 MB for 990-PFs to 68 MB for 990-EZs.
# The file 21eofinextractdoc.xlsx is a data dictionary for all three data workbooks; it's in the Data folder.

# In this script we use a 1.6 MB random sample of the 2021 990 file, Extract990_2021.xlsx
# We join that with a 300 KB extract from the Business Master File, BusinessFile_Extract.csv

# import random sample of financial data from 2021 Form 990s
Extract990_2021 <- ("Extract990_2021.xlsx")

View(Extract990_2021)

str(Extract990_2021$EIN)
# num [1:1509] 2.23e+08 2.01e+08 2.61e+08 6.36e+08 2.02e+08 ...

# convert EIN from numeric to character, width 9)
colnames(Extract990_2021)[2] <- 'ein'

Extract990_2021 <- Extract990_2021 %>% 
  mutate(EIN = as.character(ein),
         EIN = str_pad(EIN, 9, side = "left", pad = "0"))

Extract990_2021 <- Extract990_2021[,c(1,247,2:246)]

dim(Extract990_2021)
# [1] 1509  247

# see what those mysterious column names really mean
Doc990_2021 <- read_excel("21eofinextractdoc.xlsx", sheet = 1, skip = 2)

View(Doc990_2021)

# import IRS Business Master File info for our random sample of nonprofits
BizFile_Extract <- read_csv("BizFile_Extract.csv",
                   col_types = "cccccccccccncccccncccccnnncc")

View(BizFile_Extract)

# remove trailing zeroes from classification field in BizFile_Extract
BizFile_Extract <- BizFile_Extract %>%
  mutate(CLASSIFICATION = str_remove(CLASSIFICATION, "0+$"))

# import IRS nonprofit classification codes from Exempt Organization Business Master File documentation
ExemptClasses <- read_csv("ExemptClasses.csv", col_types = "ccc")

# identify nonprofits by total revenue and contributions
Extract990_2021a <- inner_join(select(BizFile_Extract, EIN, NAME, STREET, CITY, STATE, ZIP),
                               select(Extract990_2021, EIN, tax_pd,
                                      Employees = noemplyeesw3cnt,
                                      Contributions = totcntrbgfts,
                                      ProgramRev = totprgmrevnue,
                                      OtherRev = miscrevtot11e,
                                      TotalRev = totrevenue),
                               by = "EIN") %>%
  arrange(desc(TotalRev)
          
View(Extract990_2021a)
          
# use Y/N columns to identify nonprofits engaged in insider deals
Extract990_2021b <- inner_join(select(BizFile_Extract, EIN, NAME, STREET, CITY, STATE, ZIP),
                               select(Extract990_2021, EIN, 
                                      Employees = noemplyeesw3cnt,
                                      TotalRev = totrevenue,
                                      Loan2Officer = loantofficercd,
                                      Officer_Biz = servasofficercd),
                               by = "EIN") %>% 
  filter(Loan2Officer == 'Y' | Officer_Biz == 'Y')
          
View(Extract990_2021b)
          
# find contributions to groups that cannot accept tax-deductible contributions
Extract990_2021c <- inner_join(select(BizFile_Extract, EIN, NAME, STREET, CITY, STATE, ZIP, DEDUCTIBILITY),
                               select(Extract990_2021, EIN, tax_pd, 
                                      Contributions = totcntrbgfts,
                                      TotalRev = totrevenue),
                               by = "EIN") %>% 
  filter(DEDUCTIBILITY == 2) %>% 
  arrange(desc(Contributions))
          
View(Extract990_2021c)
                                      

# find percentage of employees paid over $100k
Extract990_2021a <- Extract990_2021a %>% 
  mutate(Per100k = (noindiv100kcnt / employe_cnt) * 100)

