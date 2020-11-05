system('mkdir -p render')
dirnames <- 'M2_Dataviz/'
if(is.null(dirnames)){
  system(glue::glue( 'rm -rf render'))
  dirnames <- list.files('.', pattern = 'Rmd',
                         full.names = TRUE, recursive = TRUE) %>% 
    stringr::str_extract( pattern = './\\w+/') %>% 
    str_replace_all(pattern = '\\./|/', replacement = '') %>% 
    unique() 
}



for(d_ in dirnames)
  system(glue::glue( 'cp resources/mpe_pres.css {d_}/.'))
filenames <- list.files(dirnames, pattern = 'Rmd',
                        full.names = TRUE, recursive = TRUE)

for(f_ in filenames){
  system(glue::glue( 'rm -rf {stringr::str_remove(f_, ".Rmd")}_cache'))
  system(glue::glue( 'rm -rf {stringr::str_remove(f_, ".Rmd")}_files'))
  
  rmarkdown::render(f_)
}  

for(d_ in dirnames)
  system( glue::glue( 'cp -rf  {d_} render/ '))


