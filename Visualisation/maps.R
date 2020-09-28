params <-
list(child_path = "", setup_path = "../resources/")

## ----setup, include=FALSE, eval = TRUE----------------------------------------------------------------------------------------------------
source(paste0(params$setup_path, "knitr_setup.R"))
with_sol <- TRUE ## in order to control the output
with_course <- TRUE
library('flipbookr')
library(RefManageR)


## ----reference,  include=FALSE, cache=FALSE, eval = TRUE----------------------------------------------------------------------------------
BibOptions(check.entries = FALSE,
           bib.style = "authoryear",
           cite.style = "alphabetic",
           style = "markdown",
           hyperlink = FALSE,
           dashed = FALSE)
myBib <- ReadBib("./visu.bib", check = FALSE)


## ----openstreetmap_package, eval = TRUE, echo = FALSE, fig.show = 'hide',  dpi =200, out.width='50%'--------------------------------------
##remotes::install_github("ropensci/osmdata")
rennes_bb <- osmdata::getbb('Rennes') %>% 
  as.numeric() ##get bounding box
rennes_bb
bat24 <- data.frame(lat= 48.114072, lon = -1.710184, 
                    text = 'Batiment 24')
zone_map <- ggmap::get_stamenmap(bbox = rennes_bb, 
                                 zoom = 13) 
zone_map %>%
  ggmap::ggmap() + 
  geom_point(data = bat24, aes(x= lon, y = lat), col = 'red') + 
  geom_text(data = bat24, aes(x= lon, y = lat, label = text), hjust = 0.1, nudge_x = 0.004, col = 'red' ) 


## ----class_raster, eval = TRUE, echo = TRUE-----------------------------------------------------------------------------------------------
class(zone_map)


## ----CRS_illustration, eval = TRUE, echo = TRUE-------------------------------------------------------------------------------------------
library("sf")
library("rnaturalearth")
library("rnaturalearthdata")

world <- ne_countries(scale = "medium", returnclass = "sf")


## ----sf_world_example, eval = TRUE, echo = TRUE-------------------------------------------------------------------------------------------
world %>% select(admin, income_grp, wikipedia, economy, geometry) %>% print(n=5)


## ----sf_world_example_crs, eval = TRUE, echo = TRUE---------------------------------------------------------------------------------------
st_crs(world )


## ----fig_coord_sys,  out.width = "40%", fig.cap = "Geodetic datum (source https://commons.wikimedia.org/wiki/File:Azimutalprojektion-schief_kl.jpg, author:	Stefan Kühn,  Fotograf )", eval = TRUE----
knitr::include_graphics("img/1280px-ECEF.png")


## ----sf_world_example_map,  eval = TRUE, echo = TRUE--------------------------------------------------------------------------------------
world %>%  filter(brk_name == "United States") %>% ggplot() + geom_sf()


## ----sf_world_example_map_2163,  eval = TRUE, echo = TRUE---------------------------------------------------------------------------------
world %>%   filter(brk_name == "United States") %>% st_transform(crs = 2163) %>% ggplot() + geom_sf()


## ----sf_france_example_map----------------------------------------------------------------------------------------------------------------
france_dta <-   world  %>% filter(name == 'France') 
st_crs(france_dta)
france_dta%>% ggplot() + geom_sf()


## ----france_dta_save, eval = TRUE, echo = FALSE, results='hide'---------------------------------------------------------------------------
france_dta <-   world  %>% filter(name == 'France') 


## ----sf_metro_example_map,  eval = TRUE, echo = TRUE--------------------------------------------------------------------------------------
metro_dta <- france_dta %>% st_crop( xmin = -5, xmax = 11, ymin= 40.6, ymax = 52) 
metro_dta %>% ggplot() + geom_sf()


## ----sf_metro_example_map_lambert,  eval = TRUE, echo = TRUE------------------------------------------------------------------------------
metro_dta %>% st_transform( crs = 2154 ) %>%
  ggplot() + geom_sf() 


## ----sf_metro_example_map_utm,  eval = TRUE, echo = TRUE----------------------------------------------------------------------------------
metro_dta %>% st_transform( crs = 32631 ) %>%
  ggplot() + geom_sf() 


## ----point, eval = TRUE, echo = TRUE------------------------------------------------------------------------------------------------------
x <- st_point(c(1,2))
x
class(x)


## ----plot_point, echo = TRUE, eval = TRUE, out.width = "30%"------------------------------------------------------------------------------
x %>% ggplot() + geom_sf()


## ----multipoint, eval = TRUE, echo = TRUE-------------------------------------------------------------------------------------------------
p <- rbind( c(3.2,4), c(3,4.6), c(3.8,4.4), c(3.5,3.8), c(3.4,3.6), c(3.9,4.5))
(mp <- st_multipoint(p))
mp
class(mp)


## ----multipoint_plot, echo = TRUE, eval = TRUE, out.width = '30%'-------------------------------------------------------------------------
mp %>% ggplot() + geom_sf()


## ----line, eval = TRUE, echo = TRUE-------------------------------------------------------------------------------------------------------
line_sfg <- st_linestring(p)
line_sfg
class(line_sfg)


## ----line_plot, echo = TRUE, eval = TRUE, out.width = '30%'-------------------------------------------------------------------------------
line_sfg%>% ggplot() + geom_sf()


## ----poly, eval = TRUE, echo = TRUE-------------------------------------------------------------------------------------------------------
p1 <- rbind(c(0,0), c(1,0), c(3,2), c(2,4), c(1,4), c(0,0))
p2 <- rbind(c(1,1), c(1,2), c(2,2), c(1,1))
poly_sfg <- st_polygon(list(p1, p2))
poly_sfg 
class(poly_sfg )


## ----poly_plot, echo = TRUE, eval = TRUE, out.width = '30%'-------------------------------------------------------------------------------
poly_sfg %>% ggplot() + geom_sf()


## ----read_shp_idf, echo = TRUE, eval = TRUE, message = FALSE------------------------------------------------------------------------------
idf_shape <- st_read(dsn = '../data/ile_de_france_shape/')

## ----info_shp_idf, echo = TRUE, eval = TRUE, message = FALSE------------------------------------------------------------------------------
idf_shape %>% print(n=10)


## ----info_shp_dpt, echo = TRUE, eval = TRUE, message = FALSE------------------------------------------------------------------------------
dpt_shape <-  st_read(dsn = '../data/depts/') 
dpt_shape %>% print(n=10)


## ----plot_shp_dpt, echo = TRUE, eval = TRUE, message = FALSE------------------------------------------------------------------------------
dpt_shape %>% 
  ggplot() + geom_sf()


## ----read_pop, echo = TRUE, eval = TRUE---------------------------------------------------------------------------------------------------
pop <-  readr::read_delim("~/git/courses/data/population.csv", 
    ";", escape_double = FALSE, col_types = cols(`1999` = col_double(), 
        `2007` = col_double(), `2012` = col_double(), 
        `2017` = col_double()), trim_ws = TRUE, 
    skip = 3) %>% 
  rename(CODE_DEPT = X1, p2020 = '2020 (p)', p2017 = '2017', p2012 = '2012',
          p2007 = '2007', p1999 = '1999')



## ----join_data, echo = TRUE, eval = TRUE--------------------------------------------------------------------------------------------------
dpt_complete <- dpt_shape %>% inner_join( y = pop, by = "CODE_DEPT")


## ----plot_data_dpt1-----------------------------------------------------------------------------------------------------------------------
dpt_complete %>% ggplot() + 
  geom_sf(aes(fill = p2017)) +
  scale_fill_gradient(low = "#75c9c5", high = "#fb1c05")


## ----plot_data_dpt2-----------------------------------------------------------------------------------------------------------------------
dpt_complete %>% 
  mutate(area = st_area(geometry), dens = p2017/area) %>% 
  ggplot() + 
  geom_sf(aes(fill = as.numeric(dens))) +
  scale_fill_gradient(low = "#75c9c5", high = "#fb1c05", trans = "log")


## ----tidying, eval = TRUE, echo = TRUE----------------------------------------------------------------------------------------------------
dpt_complete %>%  print(n=5)


## ----tidying_eval2------------------------------------------------------------------------------------------------------------------------
region_complete <- dpt_complete %>% 
  select(ID_GEOFLA, CODE_DEPT, NOM_DEPT, NOM_REGION,
         p2020, p2017, p2012, p2007, p1999) %>% 
  pivot_longer(cols = starts_with("p"), names_to = 'Year', values_to = 'Population'  )%>% 
  group_by(NOM_REGION, Year) %>% 
  summarise(pop = sum(Population), geometry= st_union(geometry),
            area = units::set_units(st_area(geometry), km^2), dens = (pop/area)) 

region_complete %>% 
  ggplot() + facet_wrap(~Year) + geom_sf(aes(fill = as.numeric(dens), geometry = geometry)) + 
  scale_fill_gradient(low = "#75c9c5", high = "#fb1c05", trans = "log", breaks = c(50, 150, 450), 
                      name = 'Density')



## ----refs, echo=FALSE, results="asis"-----------------------------------------------------------------------------------------------------
PrintBibliography(myBib)

