#Color Format
colFmt = function(x,color){
  outputFormat = knitr::opts_knit$get("rmarkdown.pandoc.to")
  if(outputFormat == 'latex' || outputFormat == 'beamer')
    glue::glue("\\textcolor{{{color}}}{{ {x} }}")
  else if(outputFormat == 'html')
    paste("<font color='",color,"'>",x,"</font>",sep="")
  else
    x
}


color_darj <- wesanderson::wes_palette(name = "Darjeeling1")