##################
###first quiz#####
##################
library(stringr)


#Q1
q1a <- nrow(edx)
print(paste("q1a=",q1))

q1b <- ncol(edx)
print(paste("q1b=",q1b))


#Q2
q2a <- sum(edx$rating == 0)
print(paste("q2a =", q2a))

print(paste("q2b =", sum(edx$rating == 3)))

#Q3
print(paste("q3 =",length(unique(edx$movieId))))

#Q4
print(paste("q3 =",length(unique(edx$userId))))

#Q5
my_genres <- tibble(
                    genre = c("Drama", "Comedy", "Thriller", "Romance")
                    )
my_genres$evaluations <- NA

for(i in 1:nrow(my_genres))
{
  my_genres$evaluations[i] <- sum(str_detect(edx$genres, regex(my_genres$genre[i], ignore_case = TRUE)))
}

print

#Q6
film_list <- tibble(
                    title = c("Forrest Gump", "Jurassic Park", "Pulp Fiction", "Shawshank Redemption, The", "Speed 2: Cruise Control")
                    )

film_list$num_ratings <- NA

for(i in 1:nrow(film_list))
{
  film_list$num_ratings[i] <- sum(str_detect(edx$title, regex(film_list$title[i], ignore_case = TRUE)))
}

print(film_list)
print(film_list[which.max(film_list$num_ratings), ])

edx %>% group_by(movieId, title) %>%
  summarize(count = n()) %>%
  arrange(desc(count))

#Q7
edx %>% group_by(rating) %>% 
  summarise(count = n()) %>% 
  arrange(desc(count))

#Q8
star_types <- edx %>% 
  mutate(star_type = ifelse(edx$rating %% 1 == 0, "Full Star", "Half Star")) %>%
  group_by(star_type) %>% 
  summarise(total = n()) %>% 
  mutate(percentual = (total / nrow(edx) * 100)) %>% 
  arrange(desc(total))




print(star_types)
print(star_types[which.max(star_types$total),])





