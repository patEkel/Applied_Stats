library(readxl)
library(ggplot2)
library(xlsx)
library(plyr)
library(ggmap)
library(RCurl)
library(maps)


file <-read_excel(path='C:/Users/pat/Desktop/mortality_risk.xlsx')
file <- file[c('region', 'subregion','life_expectancy')]
names(file) <- c('subregion', 'region', 'life_expectancy')
summary(file)


#file$life_expectancy <- as.character(file$life_expectancy)
#file$life_expectancy <- as.numeric(gsub(',','',file$life_expectancy))
#file$life_expectancy <- as.character(file$life_expectancy)
#file<-na.omit(file)#remove missing data

# get map data for US counties
county_map <- map_data("county")
state_map <- map_data("state")
#county_map <- county_map[c('region', 'subregion')]
#county_map <- lapply(county_map, function(x) unique(x))
county_map
# merge mortality and county_mapmortality_map <- merge(county_map, file, by.x=c("region", "subregion"), by.y=c("region", "subregion"),all.x = TRUE)


summary(mortality_map)
head(mortality_map)

#resort merged data
mortality_map <- arrange(as.data.frame(mortality_map), group, order)

head(mortality_map)
summary(mortality_map)
ggplot() + geom_map(data = mortality_map, map = state_map, aes(x=long, y=lat, map_id=region, group = group, fill = life_expectancy))

######################
g <- ggplot()
g <- g + geom_map(data = state_map, map = state_map, aes(x=long, y = lat, map_id=region),
                  fill ="#ffffff", color ="#ffffff", size =.15)
g
g <- g + geom_map(data=file, map=state_map,
                  aes(fill=life_expectancy, map_id=region),
                  color="#ffffff", size=0.15)
  
g
g <- g + scale_fill_continuous(low='thistle2', high='darkred', 
                               guide='colorbar')
g




