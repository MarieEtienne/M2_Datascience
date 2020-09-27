

functionrender_slides <- function(directory){
  system('mkdir -p render')
  lapply(list.files(directory, pattern = '.Rmd', 
             full.names = TRUE), rmarkdown::render)
  system( glue::glue( 'cp -rf  {directory} render/ '))
}


functionrender_slides('Visualisation')

