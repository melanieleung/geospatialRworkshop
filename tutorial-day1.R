# Packages
library(ggplot2)
library(sf)
library(rgdal)
library(raster)
library(dplyr)
library(tidyverse)

# working directory
setwd("C:/Users/collabuser/Desktop/geospatialWorkshop")

# getting info (metadata) and loading rasters
GDALinfo("C:/Users/collabuser/Desktop/geospatialWorkshop/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif")
HARV_dsmCrop_info <- capture.output(GDALinfo("C:/Users/collabuser/Desktop/geospatialWorkshop/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif"))

DSM_HARV <- raster("C:/Users/collabuser/Desktop/geospatialWorkshop/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif")
summary(DSM_HARV, maxsamp = ncell(DSM_HARV))

# spatial visualization
DSM_HARV_df <- as.data.frame(DSM_HARV, xy = TRUE)
str(DSM_HARV_df)

ggplot() + 
  geom_raster(data= DSM_HARV_df, aes(x = x, y = y), fill = DSM_HARV_df$HARV_dsmCrop) + # specify data, aesthetic (see in metadata)
  scale_fill_viridis_c() + 
  coord_quickmap() # fast cheat that works for this data projection

crs(DSM_HARV)
crs(DSM_HARV_df) # CRS is only for spatial objects, not dataFrames
minValue(DSM_HARV)
maxValue(DSM_HARV)
DSM_HARV <- setMinMax(DSM_HARV)
minValue(DSM_HARV)

DSM_HARV_df %>%
  summarize(min(DSM_HARV_df$HARV_dsmCrop))
summary(DSM_HARV_df)

nlayers(DSM_HARV) # to see how many bands you have

# highlight bad data
ggplot() +
  geom_raster(data = DSM_HARV_df, aes (x=x, yy, fill = HARV_dsmCrop)) +
  scale_fill_viridis_c(na.value = "deeppink") +
  coord_quickmap()

# visualizing/exploring data to find potential bad values
LandSat_SJER <- raster("C:/Users/collabuser/Desktop/geospatialWorkshop/NEON-DS-Airborne-Remote-Sensing/SJER/DTM/SJER_dtmCrop.tif")
GDALinfo("C:/Users/collabuser/Desktop/geospatialWorkshop/NEON-DS-Airborne-Remote-Sensing/SJER/DTM/SJER_dtmCrop.tif")

LandSat_SJER_df <- as.data.frame(LandSat_SJER, xy = TRUE)
str(LandSat_SJER_df)

LandSat_SJER_df %>%
  filter(if_any(everything(), ~is.na(.))) # one way of finding bad values

is.na.data.frame(LandSat_SJER_df) # another way of finding bad values

ggplot() +
  geom_raster(data = LandSat_SJER_df, aes(x=x, y=y, fill = SJER_dtmCrop)) +
  scale_fill_viridis_c(na.value = "deeppink") +
  coord_quickmap()

# see distribution of raster data
ggplot() +
  geom_histogram(data= DSM_HARV_df, aes(HARV_dsmCrop, bins = 40))


### now explore HARV_DSMhill.tif raster
HARV_dsmHill_info <- capture.output(GDALinfo("C:/Users/collabuser/Desktop/geospatialWorkshop/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_DSMhill.tif"))
HARV_dsmHill_info
DSMhill <- raster("C:/Users/collabuser/Desktop/geospatialWorkshop/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_DSMhill.tif")
summary(DSMhill, maxsamp = ncell(DSMhill))

# as data frame
DSMhill_df <- as.data.frame(DSMhill, xy = T)
str(DSMhill_df)

# visualize raster
ggplot() +
  geom_raster(data = DSMhill_df, aes(x=x, y=y, fill = DSMhill$HARV_DSMhill)) +
  scale_fill_viridis_c(na.value = "deeppink") +
  coord_quickmap()
