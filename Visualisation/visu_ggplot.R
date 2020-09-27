params <-
list(child_path = "", setup_path = "../resources/")

## ----setup,   cahe = FALSE, eval = TRUE, echo = FALSE, message = FALSE--------------------------------------------------------------------
library(flipbookr)
library(RefManageR)
library(kableExtra)
source(paste0(params$setup_path, "knitr_setup.R"))
with_sol <- FALSE ## in order to control the output
with_course <- TRUE


## ----reference,  include=FALSE, cache=FALSE, eval = TRUE----------------------------------------------------------------------------------
BibOptions(check.entries = FALSE,
           bib.style = "authoryear",
           cite.style = "alphabetic",
           style = "markdown",
           hyperlink = FALSE,
           dashed = FALSE)
myBib <- ReadBib("./visu.bib", check = FALSE)


## ----graph_bib, out.height = "150px", eval = TRUE-----------------------------------------------------------------------------------------
book1 <- ggdraw() + draw_image("https://d33wubrfki0l68.cloudfront.net/b88ef926a004b0fce72b2526b0b5c4413666a4cb/24a30/cover.png")
book2 <-  ggdraw() + draw_image("http://www.cookbook-r.com/r_graphics_cookbook.png")
book3 <-  ggdraw() + draw_image("https://geocompr.robinlovelace.net/images/cover.png")
plot_grid(book1, book2, book3, nrow = 1)


## ----load_tidyverse, message = FALSE, eval = TRUE, echo = TRUE----------------------------------------------------------------------------
library(tidyverse)


## ----tidy_ex------------------------------------------------------------------------------------------------------------------------------
set.seed(1)
n <- 8
data.frame(x = sample(1:10, size = n, replace = TRUE), y = 3*rnorm(n)) %>% 
  mutate(xplusy = x + y ) %>% 
  filter( xplusy > 4) %>% 
  select(x, y)


## ----palmer_data, eval = TRUE, echo = TRUE------------------------------------------------------------------------------------------------
#remotes::install_github("allisonhorst/palmerpenguins")
data(penguins,package = "palmerpenguins")
penguins <- penguins %>%
  rename(bill_l = bill_length_mm, bill_d = bill_depth_mm, flip_l = flipper_length_mm, bm = body_mass_g)
penguins %>%
  print(n=2)


## ----show_data_palmer, eval = TRUE, echo = TRUE-------------------------------------------------------------------------------------------

penguins %>%
  group_by(species, sex, year, island) %>%
  mutate(n = n()) %>%
  summarise_if(is.numeric, mean, na.rm = TRUE) %>%
  print(n=10)


## ----simple_scatter-----------------------------------------------------------------------------------------------------------------------
penguins %>% 
  ggplot() + 
  aes( x= bill_l, y=bill_d) + 
  geom_point()


## ----scatter_plot_species-----------------------------------------------------------------------------------------------------------------
penguins %>% 
  ggplot() +
  aes( x= bill_l, y=bill_d) +
  geom_point() + #BREAK
  aes(col = species)  #BREAK


## ----gg1_save, eval = TRUE, echo = TRUE---------------------------------------------------------------------------------------------------
gg <- penguins %>% 
  ggplot() +
  aes( x= bill_l, y=bill_d) +
  geom_point() + 
  aes(col = species)  


## ----scatter_viridis----------------------------------------------------------------------------------------------------------------------
gg + 
  scale_color_viridis_d()


## ----scatter_define_palette_wesanderson,eval = TRUE, echo = TRUE--------------------------------------------------------------------------
## remotes::install_github("wesanderson")
color_darj <- wesanderson::wes_palette(name = "Darjeeling1")


## ----scatter_wesanderson------------------------------------------------------------------------------------------------------------------
gg + 
  scale_color_manual(values = color_darj)


## ----exo_relation_cor, eval =  TRUE, echo = with_sol--------------------------------------------------------------------------------------
penguins %>% ggplot() +
  aes(x= bm, y = flip_l, col = as_factor(year) ) + 
  geom_point() + 
  scale_color_manual(values = wesanderson::wes_palette(name = "Darjeeling1"))



## ----scatter_labels_gg, eval = TRUE, echo = TRUE------------------------------------------------------------------------------------------
gg <- gg + scale_color_manual(values = color_darj) 


## ----scatter_labels-----------------------------------------------------------------------------------------------------------------------
gg  +
  labs( x = 'Bill length in mm') +
  labs(y = 'Bill depth in mm') +
  labs(color = "Species")


## ----scatter_themelight-------------------------------------------------------------------------------------------------------------------
gg  +
  labs( x = 'Bill length in mm') +
  labs(y = 'Bill depth in mm') +
  labs(color = "Species") + #BREAK
  theme_light() #BREAK


## ----scatter_thememinimal-----------------------------------------------------------------------------------------------------------------
gg + scale_color_manual(values = color_darj) +
  labs( x = 'Bill length in mm',  
        y = 'Bill depth in mm',  color = "Species") +
  theme_light() + #BREAK 
  theme_minimal() #BREAK 


## ----scatter_set_theme, eval = TRUE, echo = TRUE------------------------------------------------------------------------------------------
gg <- gg + scale_color_manual(values = color_darj) +
  labs( x = 'Bill length in mm',  y = 'Bill depth in mm',  color = "Species") +
  theme_light()


## ----preset_theme, eval = TRUE, echo = FALSE----------------------------------------------------------------------------------------------
gg


## ----scatter_below------------------------------------------------------------------------------------------------------------------------
gg + 
  theme(legend.position="bottom")


## ----scatter_within, eval = TRUE, echo = TRUE---------------------------------------------------------------------------------------------
gg + 
  theme(legend.position=c(.9, .6))


## ----scatter_custom, eval = TRUE, echo = TRUE---------------------------------------------------------------------------------------------
gg + theme(legend.position=c(.9, .6),
           text = element_text(size = 10, face = "italic"),
           axis.text.x = element_text(angle=90, hjust=1),
           legend.text = element_text(size = 9, face = 'plain'),
           legend.title = element_text(size = 11, face = "bold") )



## -----------------------------------------------------------------------------------------------------------------------------------------
gg


## ----stat_info_lm-------------------------------------------------------------------------------------------------------------------------
gg + 
  geom_smooth(method = 'lm', se = FALSE) +
  geom_smooth(method = 'loess', se = TRUE)


## ----exo_relation_cor2, eval =  TRUE, echo = with_sol-------------------------------------------------------------------------------------
penguins %>% ggplot() + 
  aes(x= bm, y = flip_l, col = as_factor(year) ) + 
  geom_point() + geom_smooth(method = 'lm') +
  scale_color_manual(values = wesanderson::wes_palette(name = "Darjeeling1"))



## ----theme_setup--------------------------------------------------------------------------------------------------------------------------

penguins %>% 
  ggplot() +
  aes( x= bill_l, y=bill_d, col = species) +
  geom_point()  #BREAK



## ----theme_setup_2------------------------------------------------------------------------------------------------------------------------

theme_set(theme_light())
theme_update(legend.position="bottom") #BREAK
penguins %>% 
  ggplot() +
  aes( x= bill_l, y=bill_d, col = species) +
  geom_point() #BREAK


## ----simple_hist--------------------------------------------------------------------------------------------------------------------------
penguins %>%
  ggplot() + aes(x = bill_l) + geom_histogram() +
  labs( x = 'Bill length in mm') +
  theme_minimal()


## ----color_hist,   echo = TRUE------------------------------------------------------------------------------------------------------------
 penguins %>%  ...


## ----color_hist_cor-----------------------------------------------------------------------------------------------------------------------
penguins %>%
  ggplot() + aes(x = bill_l, fill = species) + 
  geom_histogram(alpha = 0.5, position = 'identity') +
  labs( x = 'Bill length in mm') +
  scale_fill_manual(values = wesanderson::wes_palette('Zissou1', n = 3)) 


## ----color_hist_facet---------------------------------------------------------------------------------------------------------------------
penguins %>%
  ggplot() + aes(x = bill_l, fill = species) + 
  geom_histogram() +
  facet_wrap(~species) + 
  labs( x = 'Bill length in mm') +
  scale_fill_manual(values = wesanderson::wes_palette('Darjeeling1')) 


## ----color_hist_dens_ex-------------------------------------------------------------------------------------------------------------------

penguins %>% ...


## ----color_hist_dens_cor------------------------------------------------------------------------------------------------------------------

 penguins %>%  ggplot() + aes(x = bill_l, y = ..density..) +
  facet_wrap(~species) + 
  geom_histogram(alpha=0.5, aes( fill = species)) +
   geom_density(aes(col = species)) + 
  labs( x = 'Bill length in mm') + #BREAK
  scale_fill_manual(values = wesanderson::wes_palette('Darjeeling1')) +  #BREAK
  scale_color_manual(values = wesanderson::wes_palette('Darjeeling1'))   



## ----color_boxplot, eval = TRUE, echo = TRUE----------------------------------------------------------------------------------------------
 penguins %>%  ggplot() + aes(x = species,  y = bill_l) +
  geom_boxplot(alpha=0.5, aes( fill = species)) +
  labs( y = 'Bill length in mm') + #BREAK
  scale_fill_manual(values = wesanderson::wes_palette('Darjeeling1')) +  #BREAK
  scale_color_manual(values = wesanderson::wes_palette('Darjeeling1'))   


## ----color_boxplot_2----------------------------------------------------------------------------------------------------------------------
 penguins %>%  ggplot() + aes(x = species,  y = bill_l) +
  geom_violin(alpha=0.5, aes( fill = species)) +
  labs( y = 'Bill length in mm') + #BREAK
  scale_fill_manual(values = wesanderson::wes_palette('Darjeeling1')) 


## ----color_boxplot_3----------------------------------------------------------------------------------------------------------------------
penguins %>%  ggplot() + aes(x = species,  y = bill_l) +
  geom_boxplot(alpha=0.5, aes( fill = species)) +
  geom_jitter(color="black", size=0.4, alpha=0.8) +
  labs( y = 'Bill length in mm') + #BREAK
  scale_fill_manual(values = wesanderson::wes_palette('Darjeeling1')) 


## ----color_boxplot_sup_sub, echo = TRUE, eval = TRUE--------------------------------------------------------------------------------------
penguins %>%  mutate(mu = bill_l * bill_d) %>% 
  ggplot() + aes(y= mu ) +
  geom_boxplot(alpha=0.5, aes( fill = species)) +
  labs( y = bquote(mu~(mm^2))) +
  scale_fill_manual(values = wesanderson::wes_palette('Darjeeling1')) 


## ----ggpubr_p1, eval = TRUE, echo = TRUE--------------------------------------------------------------------------------------------------
gg_p1 <- gg
gg_p1


## ----ggpubr_p2, eval = TRUE, echo = TRUE--------------------------------------------------------------------------------------------------
gg_p2 <- penguins %>%
  ggplot()  + aes(x = bill_l, y = ..density..) + geom_histogram(alpha=0.5, aes( fill = species)) +
   geom_density(aes(col = species)) +
  labs( x = 'Bill length in mm') +
  scale_fill_manual(values = wesanderson::wes_palette('Darjeeling1')) +
  scale_color_manual(values = wesanderson::wes_palette('Darjeeling1'))
gg_p2


## ----ggpubr_p3, eval = TRUE, echo = TRUE--------------------------------------------------------------------------------------------------
##install.packages('ggpubr')
ggpubr::ggarrange(gg_p1, gg_p2, nrow=2, ncol = 1)


## ----ggpubr_p4, eval = TRUE, echo = TRUE--------------------------------------------------------------------------------------------------
ggpubr::ggarrange(gg_p1, gg_p2, nrow=2, ncol = 1, common.legend = TRUE)


## ----ggpairs, eval = TRUE, echo = TRUE----------------------------------------------------------------------------------------------------
##install.packages('GGally')
library(GGally)
penguins %>% ggpairs(columns = c(1,3,4,5), mapping = aes(col = species)) +
scale_color_manual(values = wesanderson::wes_palette('Darjeeling1'))+
scale_fill_manual(values = wesanderson::wes_palette('Darjeeling1')) + theme(text = element_text(size = 6))


## ----ggpairs_fancy, eval = TRUE, echo = TRUE----------------------------------------------------------------------------------------------
penguins %>% ggpairs(columns = c(1,3,4,5), mapping = aes(col = species),
                     upper = list(continuous = wrap( "cor",size = 2)),
                     lower = list(continuous = wrap('points', size = .5))) +
  scale_color_manual(values = wesanderson::wes_palette('Darjeeling1'))+
  scale_fill_manual(values = wesanderson::wes_palette('Darjeeling1')) + theme(text = element_text(size = 6))


## ----ani_final, eval = T, echo = T--------------------------------------------------------------------------------------------------------
library(gganimate)
gg  +
  transition_states(year)  +
  geom_text(x = 56 , y = 15,
            aes(label = as.character(year)),
            size = 8, col = "grey50") +
  theme(legend.position="bottom") 


## ----plotly, eval = T, echo = T, fig.height=5, fig.width=4--------------------------------------------------------------------------------
library(plotly)
gg  %>%  ggplotly()


## ----refs, echo=FALSE, results="asis", eval = TRUE, cache = FALSE-------------------------------------------------------------------------
PrintBibliography(myBib)

