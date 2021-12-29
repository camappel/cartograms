library(maptools)
library(sf)
library(ggplot2)
library(dplyr)
library(cartogram)

data <- read.csv("https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/latest/owid-covid-latest.csv") %>% select(iso_code, new_vaccinations_smoothed)
colnames(data)[1] <- "ISO3"

countries = c('Austria', 'Belgium', 'Bulgaria', 'Cyprus', 'Czech Republic', 'Denmark', 'Estonia', 'Finland', 'France', 'Germany', 'Greece', 'Hungary', 'Iceland', 'Ireland', 'Italy', 'Latvia', 'Lithuania', 'Luxembourg', 'Malta', 'Netherlands', 'Norway', 'Poland', 'Portugal', 'Slovenia', 'Spain', 'Sweden', 'United Kingdom')
data(wrld_simpl)
mapsimple = wrld_simpl[wrld_simpl$NAME %in% countries,]

sfno <- st_as_sf(mapsimple)
st_crs(sfno)

data <- merge(sfno, data, "ISO3")

sfproj <- st_transform(data, crs = 23038)
st_crs(sfproj)

cartogram <- cartogram_cont(sfproj, "new_vaccinations_smoothed")

ggplot() +
  geom_sf(data = cartogram, aes(fill = new_vaccinations_smoothed))


