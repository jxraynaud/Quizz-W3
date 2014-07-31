temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv ",temp)
DF <- read.table(temp,sep=",",header=TRUE)
unlink(temp)
agricultureLogical <- DF$ACR == 3 & DF$AGS == 6
head(DF[which(agricultureLogical),],n=3)
