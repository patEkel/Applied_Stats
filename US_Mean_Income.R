library(RCurl)
library(xlsx)
urlfile <-'http://www.psc.isr.umich.edu/dis/census/Features/tract2zip/MeanZIP-3.xlsx'
destfile <- "census20062010.xlsx"
download.file(urlfile, destfile, mode="wb")
census <- read.xlsx2(destfile, sheetName = "Mean")
head(census)
census <- census[c('Zip','Mean')]
names(census) <- c('Zip','Mean')
head(census)
census$Mean <- as.character(census$Mean)
census$Mean <- as.numeric(gsub(',','',census$Mean))
head(census)
library(zipcode)
data("zipcode")
census$Zip <- clean.zipcodes(census$Zip)
census <- merge(census, zipcode, by.x='Zip', by.y='zip')
head(census)
library(ggmap)
map<-get_map(location='united states', zoom=4, maptype = "terrain",
             source='google',color='color')

print(head(census,5))
library(ggplot2)
ggmap(map) + geom_point(
  aes(x=longitude, y=latitude, show_guide = TRUE, colour=Mean), 
  data=census, alpha=.15, na.rm = T)  + 
  scale_color_gradient(low="beige", high="blue")
