library(RCurl)
library(readxl)
file <-read_excel(path='C:/Users/pat/Desktop/Mortality_Risk.xlsx')
head(file)
file <- file[c('Location','life_expectancy')]
names(file) <- c('State','Life_Expectancy')
head(file)
file$Life_Expectancy <- as.character(file$Life_Expectancy)
file$Life_Expectancy <- as.numeric(gsub(',','',file$Life_Expectancy))
head(file)
names(file) <- c('Location','Life_Expectancy')
head(file)
library(count)
data("county")
head(zipcode)
file <- merge(file, zipcode, by.x='Location', by.y='zip')



library(ggmap)
map<-get_map(location='united states', zoom=4, maptype = "terrain",
             source='google',color='color')




print(head(file,5))
library(ggplot2)
ggmap(map) + geom_point(aes(x=longitude, y=latitude, show_guide = TRUE, colour=Life_Expectancy, 
  data=file, alpha=.15, na.rm = T)  + 
  scale_color_gradient(low="beige", high="blue")
  

  

  
  
  
