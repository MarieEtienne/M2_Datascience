

functionrender_slides <- function(directory){
  brows
  if( file.exists(file.path(directory,'render')) ){
    system(glue::glue('rm -rf {file.path(directory,"render")}'))
  } else {
    system(glue::glue('mkdir {file.path(directory,"render")}'))
  }
  lapply(list.files(directory, pattern = '.Rmd', 
             full.names = TRUE), rmarkdown::render)
  lapply(list.files(directory,  
                    recursive = TRUE), function(file_){
                      if(file_ != 'render')
                        file.copy(file.path(directory, file_),  
                                  to = file.path(directory, "render"),
                                  recursive=TRUE)
                    }
  )
  
}



