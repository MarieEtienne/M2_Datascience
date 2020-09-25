

functionrender_slides <- function(dir){
  lapply(list.files(dir, pattern = '.Rmd', 
             full.names = TRUE), rmarkdown::render)
  if( file.exists(file.path(dir,'render')) ){
    system(glue::glue('rm -rf {{file.path(dir,"render")}}'))
  } else {
    system(glue::glue('mkdir {{file.path(dir,"render"")}}'))
  }
}



