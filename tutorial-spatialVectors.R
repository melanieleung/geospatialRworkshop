library(sf)
library(ggplot2)
library(raster)
library(tidyverse)

# load data and get info
aoi_boundary_HARV <- st_read("C:/Users/collabuser/Desktop/geospatialWorkshop/NEON-DS-Site-Layout-Files/HARV/HarClip_UTMZ18.shp")
st_geometry_type(aoi_boundary_HARV) # object type
st_crs(aoi_boundary_HARV) # CRS
st_bbox(aoi_boundary_HARV) # extent

# plot
ggplot() +
  geom_sf(data = aoi_boundary_HARV, size = 3, color = "black", fill = "cyan1") +
  ggtitle("AOI boundary plot") +
  coord_sf()

# import line and point shapefiles
lines_HARV <- st_read("C:/USers/collabuser/Desktop/geospatialWorkshop/NEON-DS-Site-Layout-Files/HARV/HARV_roads.shp")
points_HARV <- st_read("C:/USers/collabuser/Desktop/geospatialWorkshop/NEON-DS-Site-Layout-Files/HARV/HARVtower_UTM18N.shp")

class(lines_HARV)
class(points_HARV)

st_crs(lines_HARV)
st_crs(points_HARV)

st_bbox(lines_HARV)
st_bbox(points_HARV)

# exploring attribute tables
names(lines_HARV) # names of columns
head(lines_HARV) # first six columns
ncol(points_HARV)
# explore values in an attribute
levels(lines_HARV$TYPE)

# subsetting
footpath_HARV <- lines_HARV %>%
  filter(TYPE == "footpath")

# plotting
ggplot() +
  geom_sf(data = footpath_HARV) +
  ggtitle("NEON Harvard Field Site", subtitle = "footpaths") + 
  coord_sf()

ggplot() +
  geom_sf(data = footpath_HARV, aes(color = factor(OBJECTID)), size = 1.5) +
  labs(color = "Footbath ID") +
  ggtitle("NEON Harvard Field Site", subtitle = "footpaths") + 
  coord_sf()

# subset out all boardwalk from the lines layer and plot it
boardwalk_HARV <- lines_HARV %>%
  filter(TYPE == "boardwalk")

ggplot() +
  geom_sf(data = boardwalk_HARV, size = 1.5) +
  ggtitle("NEON Harvard Field Site", subtitle = "Boardwalks") +
  coord_sf()

# subset out all stone wall features from lines layer and plot it
lines_HARV %>%
  filter(TYPE == "stone wall") %>%
ggplot() +
  geom_sf(aes(color = factor(OBJECTID)), size = 1.5) +
  labs(color = "Wall ID") +
  ggtitle("NEON Harvard Field Site", subtitle = "Stonewalls") +
  coord_sf()



