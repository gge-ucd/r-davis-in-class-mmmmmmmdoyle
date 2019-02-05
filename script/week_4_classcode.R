# Week 4
# Intro to data frames


download.file(url = "https://ndownloader.figshare.com/files/2292169", destfile = "data/portal_data_joined.csv")
# how to download a file and telling your pc how to save it (including file extension abbrev.)
# portal_data_joined is now in data folder

surveys <- read.csv(file = "data/portal_data_joined.csv")

# read.csv tab to bring up file, then make quotes, and tab iside them to find data path
surveys

# building toolset on how to look at data

head(surveys)

# head spits out column headers and first 6 lines of data; data frame is how r stores tables of data; every column is a vector; golden rule of vectors, same type of data must be used

str(surveys)
# gives info for the data frame; int = integer, factor w/x levels = categorical data

dim(surveys)
#rows then columns

nrow(surveys)
ncol(surveys)

tail(surveys)

names(surveys)
# names of columns returns column names in a character vector of all columns in data set

rownames(surveys)
summary(surveys)

# good first stop to check that things look ok. 

# subsetting dataframes
# subsetting vectors by giving them a location index

animal_vec <- c("mouse", "rat", "cat")
animal_vec[2]

#data frames are 2D

surveys[1,1]
head(surveys)
# this means asked for first row, first column
# head is how you check 
surveys[2,1]

# pull out whole first column, blank for row it pulls it out as a VECTOR
surveys[,1]

# pull out whole first column, using a single number will give us a DATA FRAME with one column
surveys[1]

# vector

# pull out the first 3 values in the 6th column
surveys[1:3,6]

# creating a vector to get a slice of data
animal_vec[c(1,3)]

# pull out a whole single observation ie one row
surveys[5,]

# negative sign to exclude indices

surveys[1:5,-1]

str(surveys[-c(10, 15,20),])

# c will tell it to make a vector
surveys[c(10,15,30,10),]

# more ways to subset data
# data frame

surveys["plot_id"] # single column as data.frame

surveys[,"plot_id"] # single column as a vector

surveys[["plot_id"]] # will give single column as a vector

# we will come back to using double brackets with lists

surveys$year # single column as a vector, might not be good for all purposes

# challenge Challenge
#Create a data.frame (surveys_200) containing only the data in row 200 of the surveys dataset.

surveys[200,]
#Notice how nrow() gave you the number of rows in a data.frame?
#  Use that number to pull out just that last row in the data frame.
#Compare that with what you see as the last row using tail() to make sure it’s meeting expectations.
nrow(surveys)
surveys[34786,]
tail(surveys)

#Pull out that last row using nrow() instead of the row number.
#Create a new data frame (surveys_last) from that last row.
surveys_last <- surveys[nrow(surveys),]

#Use nrow() to extract the row that is in the middle of the data frame. Store the content of this row in an object named surveys_middle.
#Combine nrow() with the - notation above to reproduce the behavior of head(surveys), keeping just the first through 6th rows of the surveys dataset.

surveys_middle <- surveys[nrow(surveys)/2,]
surveys_middle

surveys[-c(7:nrow(surveys)),]

# Finally, factors

surveys$sex
# create our own factor

sex <- factor(c("male", "female", "female", "male"))
class(sex)
typeof(sex)

# levels gives back a character vector of the levels
levels(sex)
levels(surveys$genus)

nlevels(sex)

concentration <- factor(c("high", "medium", "high", "low"))

concentration <- factor(concentration, levels = c ("low", "medium", "high"))
concentration

# let's try adding to a factor
concentration <- c(concentration, "very high")
concentration

# coerces to characters if you add a value that doesn't match a current level

# changes concentration low med high to 1 2 3 and adds very high, so frustrating. should use a character instead

# let's just make em characters
as.character(sex)


# factors with numeric levels
year_factor <- factor(c(1990, 1923, 1965, 2018)) # these are just labels
as.numeric(year_factor) # we do not get the years back, we get underlying integer values

as.character(year_factor)

# this will actually give us a numeric vector
as.numeric(as.character(year_factor))


# recommended way, year factor = numbers stored in integers
as.numeric(levels(year_factor))[year_factor]
# safest way to do stuff, factors and vectors just be careful with these
# why the heck all the factors?

surveys_no_factors <- read.csv(file = "data/portal_data_joined.csv", stringsAsFactors = FALSE)
str(surveys_no_factors)

# rename factors
sex <- surveys$sex
levels(sex)
# levels includes the blank

levels(sex)[1]
levels(sex)[1] <- "undetermined"
levels(sex)

head(sex)

# working with dates

# working with dates
library(lubridate)

# ymd year month date, how you want your date to look 
my_date <- ymd("2015-01-01")
my_date
str(my_date) #structure has format

#paste takes values and stitches them together into one printed string 
my_date <- ymd(paste("2015", "05", "17", sep = "-"))
my_date

paste(surveys$year, surveys$month, surveys$day, sep = "-")

surveys$date <- ymd(paste(surveys$year, surveys$month, surveys$day, sep = "-"))
surveys$date

surveys$date[is.na(surveys$date)]