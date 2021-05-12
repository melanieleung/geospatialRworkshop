# Packages
library(ggplot2)
library(sf)
library(rgdal)
library(raster)
library(dplyr)


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
DSM_HARV_DF %>%
  summarize(minValue())
  # get max and min from dataFrame version