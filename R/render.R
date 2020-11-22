#system('rm -rf render')
system('mkdir -p render')
dirnames <- stringr::str_split(
  list.files('.', pattern = '.Rmd',
             full.names = TRUE, recursive = TRUE) ,
  pattern = '/', simplify = TRUE)[,2] 
dirnames <- unique(dirnames)

for(directory in dirnames){
  filenames <- list.files(directory, pattern = '.Rmd',
                          full.names = TRUE)
  system(glue::glue( 'cp resources/mpe_pres.css {directory}/.'))
  
  for(f_ in filenames){
    system(glue::glue( 'rm -rf {stringr::str_remove(f_, ".Rmd")}_cache'))
    system(glue::glue( 'rm -rf {stringr::str_remove(f_, ".Rmd")}_files'))
    
    rmarkdown::render(f_)
  }
  system( glue::glue( 'cp -rf  {directory} render/ '))
  
}