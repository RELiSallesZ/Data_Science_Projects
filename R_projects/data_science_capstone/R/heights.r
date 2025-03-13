library(dslabs)
library(ggplot2)
library(tidyverse)
library(caret)
library(purrr)
set.seed(2007)
#carrega o dataset
data("heights")


#definir o outcome e os features
y <- heights$sex
x <- heights$height

#deixa a aleatoriedade previsivel, acerta os ponteiros da aleatoriedade


#cria uma lista de indices "aleatorios" para para dividir o dataset em teste e trainning
test_index <- createDataPartition(y, times = 1, p = 0.5, list = FALSE)

#test_set vai ser um novo dataset formado pelos indicers do test index cruzados com o dataset carregado
test_set <- heights[test_index,]

#trainning_set vai ser todo o dataset MENOS os indices que vc tacou no test_set (ovibus, seu jegue)
training_set <- heights[-test_index,]






#o primeiro argumento de sample eh o que será possível sortear no caso "Male" e "Female"
x_sample_height_sex <- c("Male", "Female")

#o segundo argumento de sample eh o tamanho do da amostra, como estamos usando sample para chutar os valores, vamos 
#criar essa amostra usando LENGTH
test_size = nrow(test_set)
test_size
# y_hat são as previsoes... vamos chutar as previsoes usando o sample
#o sample eh uma funcao que recebe os seguintes argumentos 

y_hat <- sample(x_sample_height_sex, size = test_size, replace = TRUE) %>% 
  #agora usa o pipe p pasar a lista criada por sample para a funcao factor que vai otimizar as coisas
  factor(levels = levels(test_set$sex))

#Dai a gente compara o percentual de acerto, do que chutamos com o que era de verdade.... yhat e y
round(mean(y_hat == test_set$sex), 2)

#olhando a tabelinha
heights %>% group_by(sex) %>% summarise(mean(height), sd(height))

#aqui pula p 79% se colocar homem dentro de 2 desvios padrado da parada mto loka lah
y_hat <- ifelse(heights$height > 62, "Male", "Female")
round(mean(y_hat == y),3)

#fazendo o graficuzinho
cutoff <- seq(0, 70)

accuracy_func <- function(nbr)
{
  y_hat <- ifelse(training_set$height > nbr, "Male", "Female") %>% 
    factor(levels = levels(test_set$sex))
  mean(y_hat == training_set$sex)
}

accuracy <- map_dbl(cutoff, accuracy_func)

plot(cutoff, accuracy)

best_cutoff <- cutoff[which.max(accuracy)]
best_cutoff





