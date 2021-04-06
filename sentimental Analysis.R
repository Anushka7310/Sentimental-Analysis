library(janeaustenr)
library(stringr)
library(tidytext)
library(dplyr)

tidy_data <- austen_books() %>%
  group_by(book) %>%
  mutate(linenumber = row_number(),
         chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]", 
                                                 ignore_case = TRUE)))) %>%
  ungroup() %>%
  unnest_tokens(word, text)

#retrieving 'bing' lexicon using the get_sentiments() function.

positive_senti <- get_sentiments("bing") %>%
  filter(sentiment == "positive")

#using the “bing” lexicon and also implementing filter()  function over the words that correspond to joy.
tidy_data %>%
  filter(book == "Emma") %>%
  semi_join(positive_senti) %>%
  count(word, sort = TRUE)

#Here we will use spread() function to segregate our data into separate columns of positive and negative sentiments.
# We will then use the mutate() function to calculate the total sentiment, that is, the difference between positive and negative sentiment.

library(tidyr)
bing <- get_sentiments("bing")
Emma_sentiment <- tidy_data %>%
  inner_join(bing) %>%
  count(book = "Emma" , index = linenumber %/% 80, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative)

library(ggplot2)
ggplot(Emma_sentiment, aes(index, sentiment, fill = book)) +
  geom_bar(stat = "identity", show.legend = TRUE) +
  facet_wrap(~book, ncol = 2, scales = "free_x")

counting_words <- tidy_data %>%
  inner_join(bing) %>%
  count(word, sentiment, sort = TRUE)
head(counting_words)

#performing visualization of sentiment score,and plotting the scores along the axis that is labeled with both positive as well as negative words.
#using ggplot() function to visualize our data based on their scores.


counting_words %>%
  filter(n > 150) %>%
  mutate(n = ifelse(sentiment == "negative", -n, n)) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n, fill = sentiment))+
  geom_col() +
  coord_flip() +
  labs(y = "Sentiment Score")

#In the final visualization, we are creating a wordcloud that will delineate the most recurring positive and negative words.
#In particular, we will use the comparision.cloud() function to plot both negative and positive words in a single wordcloud 
# install.packages("reshape2")
# install.packages("wordcloud")
library(reshape2)
library(wordcloud)
tidy_data %>%
  inner_join(bing) %>%
  count(word, sentiment, sort = TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = c("red", "dark green"),
                   max.words = 100)



