library(jpeg)

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg",temp,mode="wb")
img <- readJPEG(temp, native = TRUE)
unlink(temp)
quantile(img, c(0.3, 0.8))