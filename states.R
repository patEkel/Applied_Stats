library(ggplot2)
library(dplyr)
library(readxl)

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
g <- g + geom_map(data=file, map=up, aes(fill=value, map_id=state), color="#ffffff", size=0.15)
g
###################### COUNTY #################################
up <- map_data("county")
state_map <-map_data("state")
file <-read_excel(path='C:/Users/pat/Desktop/mortality_risk.xlsx')
file <- file[c('region','subregion', 'life_expectancy')]
file<-na.omit(file)#remove missing data
head(file)
up
file$life_expectancy <- as.numeric(file$life_expectancy)
file$life_expectancy
g <- ggplot()
g <- g+geom_map(data = up, map = up, aes(x=long, y=lat, map_id=region), 
                fill="#ffffff", color="#ffffff", size=.15)

g
g <- g + geom_map(data=file, map=up, aes(fill=life_expectancy, map_id=subregion), color="#ffffff", size=0.15) +
  labs(x=NULL, y=NULL) + 
  coord_map("albers", lat0 = 39, lat1 = 45) + 
  theme(panel.border = element_blank()) + 
  theme(panel.background = element_blank()) + 
  theme(axis.ticks = element_blank()) + 
  theme(axis.text = element_blank())
g
  #geom_path(data = state_map , colour = "red", aes(x ="#ffffff", y ="#ffffff"))
