install_if_missing <- function(package) {
  if (!requireNamespace(package, quietly = TRUE)) {
    install.packages(package)
  }
  library(package, character.only = TRUE)
}

install_if_missing("ggplot2")
install_if_missing("lattice")
install_if_missing("dslabs")
install_if_missing("caret")
install_if_missing("ISLR")    
  
data(heights)  
set.seed(2007)

test_index <- createDataPartition(heights$sex, times = 1,p = 0.5,list = FALSE)

test_set <- heights[test_index,]
train_set <- heights[-test_index,]

mnist <- read_mnist()