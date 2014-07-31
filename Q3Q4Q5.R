library(plyr)
library(Hmisc)
## first file

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",temp)
rawGDP <- read.table(temp,sep=",",header=FALSE, skip=5, nrows=190, quote="\"") # On garde juste la partie qui nous intéresse.
GDP <- rawGDP[,c(1,2,4,5)] # On dégage les cols qui ne servent à rien.
names(GDP)<-c("CountryCode", "Ranking", "Country", "GDP2012") 
GDP$Country <- as.character(GDP$Country)
GDP$GDP2012<-as.numeric(gsub(",","",GDP$GDP2012)) #pour transformer les chaines de char en numeric en dégageant les ,.
unlink(temp)

## second file.

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",temp)
EDU <- read.table(temp,sep=",",header=TRUE,na.strings="",fill=TRUE,quote="\"")
unlink(temp)

## Combien de CC communs ?
length(intersect(GDP$CountryCode,EDU$CountryCode))
## Pays qui est dans GDP et pas dans EDU
GDP[GDP$CountryCode==setdiff(GDP$CountryCode,EDU$CountryCode),]

## merge the data on Country Code dropping the data for countries that are on EDU but not GDP
DF <- merge(GDP,EDU,by="CountryCode",all=TRUE)

## row = 13
DF[order(DF$GDP2012,na.last=TRUE),][13,"Country"]
DF <- DF[order(DF$GDP2012, na.last=TRUE),]

## question 4 :
tapply(DF$Ranking,DF$Income.Group,mean,na.rm=TRUE)

## question 5:

DF$Ranking.Group = cut2(DF$Ranking, g=5)
table(DF$Ranking.Group,DF$Income.Group)