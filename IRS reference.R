#################
# IRS reference #
#################

# this script imports, unzips and cleans tax-exempt organization files from IRS
# the files range in size from 90 MB to 320 MB

# set working directory, then load packages (must be installed first)
setwd()
library(tidyverse)
library(httr)
library(lubridate)

# import Publication 78 list of orgs that can accept tax-deductible contributions; size is 90 MB.
temp1 <- tempfile()
download.file("https://apps.irs.gov/pub/epostcard/data-download-pub78.zip", temp1, 
              mode = "wb")
unzip(temp1,"data-download-pub78.txt") 
unlink(temp1)
Charities <- read_delim("data-download-pub78.txt", delim="|", skip = 2, 
                        col_names = FALSE)
                        
# View Charities data frame - six unnamed columns 
View(Charities)

# add names to columns in Charities data frame
colnames(Charities)[1] <- 'EIN'
colnames(Charities)[2] <- 'Organization'
colnames(Charities)[3] <- 'City'
colnames(Charities)[4] <- 'State'
colnames(Charities)[5] <- 'Country'
colnames(Charities)[6] <- 'Type'

# import list of nonprofits that lost their tax-exempt status; size is 120 MB.
temp2 <- tempfile()
download.file("https://apps.irs.gov/pub/epostcard/data-download-revocation.zip", 
              temp2, mode = "wb")
unzip(temp2, "data-download-revocation.txt")
unlink(temp2)
Revoked <- read_delim("data-download-revocation.txt", delim = "|", skip = 2,
                      col_names = FALSE)

# View Revoked data frame - 12 unnamed columns
View(Revoked)

# add names to columns in Revoked data frame
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

# convert date fields in Revoked from character to date format
Revoked <- Revoked %>% 
  mutate(Date1 = dmy(Date1),
         Date2 = dmy(Date2),
         Date3 = dmy(Date3))

# import nonprofits filing 990-N's (e-Postcards); size is 236 MB.
temp3 <- tempfile()
download.file("https://apps.irs.gov/pub/epostcard/data-download-epostcard.zip", 
              temp3, mode = "wb")
unzip(temp3, "data-download-epostcard.txt")
unlink(temp3)
Postcard <- read_delim("data-download-epostcard.txt", delim = "|", skip = 2,
                       col_names = FALSE)

# view Postcard data frame - 26 unnamed columns
View(Postcard)

# add names to columns in Postcard data frame
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

# convert Postcard date fields from character to date format
Postcard <- Postcard %>% 
  mutate(FYBegin = mdy(FYBegin),
         FYEnd = mdy(FYEnd))

# import Exempt Organization Business Master File - virtually all tax-exempt groups - four regional files, combined size 320 MB.
# combine into a single file
BizFile1 <- read_csv("https://www.irs.gov/pub/irs-soi/eo1.csv", col_types = "cccccccccccncccccncccccnnncc")
BizFile2 <- read_csv("https://www.irs.gov/pub/irs-soi/eo2.csv", col_types = "cccccccccccncccccncccccnnncc")
BizFile3 <- read_csv("https://www.irs.gov/pub/irs-soi/eo3.csv", col_types = "cccccccccccncccccncccccnnncc")
BizFile4 <- read_csv("https://www.irs.gov/pub/irs-soi/eo4.csv", col_types = "cccccccccccncccccncccccnnncc")

BizFileAll <- rbind(BizFile1,
                    BizFile2,
                    BizFile3,
                    BizFile4)

# remove trailing zeroes from Classification field in BizFileAll
BizFileAll <- BizFileAll %>%
  mutate(Classification = str_remove(CLASSIFICATION, "0+$"))
