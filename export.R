exportPlot <- function(filename) {
  # using the graphics package to copy the plot to the current folder.
  #dev.copy(png, file=filename, width=480, height=480)
  dev.copy(png, file=filename)
  dev.off()
  cat("Your plot is ready!")
}

exportGGPlot <- function(plot) {
  # when using ggplot functions, print() must be used for rendering the graphs
  print(plot)
  dev.off()
}