library(raster)
library(rgdal)
library(ggplot2)
library(dplyr)
library(tidyverse)

DSM_HARV_df <- DSM_HARV_df %>%
  mutate(fct_elevation = cut(HARV_dsmCrop, breaks = 3))

ggplot() +
  mutate(fct_elevation = cut(HARV_dsmCrop, breaks = 3))

unique(DSM_HARV_df, aes(fct_elevation))
DSM_HARV_df %>% group_by(fct_elevation) %>%
  count()

# creat custom bins
custom_bins <- c(300, 350, 400, 450)
str(custom_bins)

DSM_HARV_df <- DSM_HARV_df %>%
  mutate(fct_elevation_2 = cut(HARV_dsmCrop))
unique(DSM_HARV_df$fct_elevation_2)

ggplot() + 
  geom_bar(data= DSM_HARV_df, aes(fct_elevation_2))

ggplot() +
  geom_raster(data = DSM_HARV_df, aes(x=x, y=y, fill=fct_elevation_2)) +
  coord_quickmap()

# plot with nicer colors and additional fun stuff like axis formatting
terrain.colors(3)
ggplot() +
  geom_raster(data = DSM_HARV_df, aes(x=x, y=y, fill=fct_elevation_2, )) +
  scale_fill_manual(values = terrain.colors(3), name = "Elevation") +
  theme(axis.title = element_blank()) +
  coord_quickmap()

### add a hillshade (via overlaying)
DSM_hill_HARV <- raster("C:/Users/collabuser/Desktop/geospatialWorkshop/NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_DSMhill.tif")
DSM_hill_HARV_df <- as.data.frame(DSM_hill_HARV, xy=T)
str(DSM_hill_HARV_df)

ggplot() +
  geom_raster(data = DSM_hill_HARV_df,
              aes(x=x, y=y, alpha = HARV_DSMhill)) +
  scale_alpha(range = c(0.15, 0.65))
# make sure crs is the same before overlaying

