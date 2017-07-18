library(ggplot2)
library(dplyr)
library(readxl)
library(RColorBrewer)

####################### STATE ###########################################
up <- map_data("state")
file <-read_excel(path='C:/Users/pat/Desktop/mortality_risk.xlsx')
file <- file[c('state','value')]
file<-na.omit(file)#remove missing data
file <- mutate(file, state = tolower(state))
head(file)
file$value <- as.numeric(file$value)
file$value
g <- ggplot()
g <- g+geom_map(data = up, map = up, aes(x=long, y=lat, map_id=region), 
                fill="#ffffff", color="#ffffff", size=.15)

g
g <- g + geom_map(data=file, map=up, aes(fill=value, map_id=state), color="#333333", size=0.15)
g
###################### COUNTY #################################
up <- map_data("county")
file <-read_excel(path='C:/Users/pat/Desktop/mortality_risk.xlsx')
up$region
file <- file[c('region','subregion', 'life_expectancy')]
#names(file) <- c('subregion', 'region', 'life_expectancy')
file<-na.omit(file)#remove missing data
head(file)
up$subregion
up$region
file$life_expectancy <- as.numeric(file$life_expectancy)

g <- ggplot()
g <- g+geom_map(data = up, map = up, aes(x=long, y=lat, map_id=region), 
                fill="#000000", color="#333333", size=.15)

g
g <- g + geom_map(data=file, map=up, aes(fill = life_expectancy, map_id = region), color = "#333333", size = .15) +
  scale_fill_gradient(high = "white", low = "red", guide = "colorbar") +
  theme(panel.border = element_blank()) + 
  theme(panel.background = element_blank()) + 
  theme(axis.ticks = element_blank()) + 
  theme(axis.text = element_blank())
g
################ TEST COUNTY   ################33
file <-read_excel(path='C:/Users/pat/Desktop/mortality_risk.xlsx')
file <- file[c('_region', '_subregion','_life_expectancy')]
names(file) <- c('subregion', 'region', 'life_expectancy')
file <- mutate(file, region = tolower(region), subregion = tolower(subregion))
file$life_expectancy <- as.numeric(file$life_expectancy)
summary(file)
file<-na.omit(file)#remove missing data
# get map data for US counties
county_map <- map_data("county")
#merge mortality and county_map
mortality_map <- merge(county_map, file, by.x=c("region", "subregion"), by.y=c("region", "subregion"), all.x=TRUE)
mortality_map <- arrange(as.data.frame(mortality_map), group, order)
mortality_map
county_map

up<-map_data("county")
ggplot(mortality_map, aes(x=long, y=lat, group = group, fill = life_expectancy)) +
  geom_map(data=mortality_map, map=up, aes(fill = life_expectancy, map_id = region))+
  geom_polygon()+ coord_map()+
  scale_fill_gradient(high = "white", low = "red", guide = "colorbar") +
  #scale_fill_gradientn("" ,colours=rev(brewer.pal(9,"YlOrRd"))) +
  labs(title="2010 Adult Obesity by Country, percent",x="",y="")
  theme_bw()  

