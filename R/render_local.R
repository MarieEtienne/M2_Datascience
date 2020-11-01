directory <- 'M2_Dataviz'
filenames <- list.files(directory, pattern = 'Rmd',
                          full.names = TRUE)

system(glue::glue( 'cp resources/mpe_pres.css {directory}/.'))
  
for(f_ in filenames){
  system(glue::glue( 'rm -rf {stringr::str_remove(f_, ".Rmd")}_cache'))
  system(glue::glue( 'rm -rf {stringr::str_remove(f_, ".Rmd")}_files'))
  rmarkdown::render(f_)
}

system( glue::glue( 'cp -rf  {directory} render/ '))
  
