# For this script to work, the working directory MUST be set to this project's analysis subdirectory.
# R.app and Rstudio.app by default set the working directory to a file's origin
# If things don't work, that's the first place to start troubleshooting.

# Set directories from which to read/write data and write figures
INTERACTIVE <- FALSE
if(INTERACTIVE){
  analysis_dir <- dirname(file.choose()) # choose this script file
  setwd(analysis_dir)
} else {
  analysis_dir <- getwd()
}
data_dir <- file.path("..", "data")
fig_dir <- file.path("..", "figures")

#-------------------------------------------------------------------------------
# LOAD DATA

diamonds1K_file <- "diamonds1K.csv"

diamonds1K <- read.csv(
	file = file.path(data_dir, diamonds1K_file),
	stringsAsFactors = FALSE
	)

#-------------------------------------------------------------------------------
# LOAD FUNCTIONS

R_files <- list.files(path = "functions", pattern = "\\.R$", full.names = TRUE)
sapply(R_files, source)


#-------------------------------------------------------------------------------
# CLEAN DATA

# woops, someone accidentally entered "Very Good", instead of "Very Diamond"
diamonds1K$cut <- gsub("Very Good", "Very Diamond", diamonds1K$cut)

# woops, someone accidentally entered "Ideal", instead of "WOW"
diamonds1K$cut <- gsub("Ideal", "WOW", diamonds1K$cut)

# make sure the levels of "cut" reflect their order
diamonds1K$cut <- ordered(diamonds1K$cut, 
  levels = c("Fair", "Good", "Very Diamond", "Premium", "WOW"))
