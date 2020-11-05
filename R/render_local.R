## Specify a directeory to generate the rmd files from
## by defaults generates all rmd
directory <- 'M2_Dataviz'
if(is.null(directory)){
  system(glue::glue( 'rm -rf render'))
  directory <- list.files('.', pattern = 'Rmd',
                          full.names = TRUE, recursive = TRUE) %>% 
    stringr::str_extract( pattern = './\\w+/') %>% 
    str_replace_all(pattern = '\\./|/', replacement = '') %>% 
    unique() 
  directory
}

filenames <- list.files(directory, pattern = 'Rmd',
                        full.names = TRUE, recursive = TRUE)

for(d_ in directory){
  system(glue::glue( 'cp resources/mpe_pres.css {d_}/.'))
}

for(f_ in filenames){
  # system(glue::glue( 'rm -rf {stringr::str_remove(f_, ".Rmd")}_cache'))
  # system(glue::glue( 'rm -rf {stringr::str_remove(f_, ".Rmd")}_files'))
  rmarkdown::render(f_)
}

system( glue::glue( 'cp -rf  {directory} render/ '))


