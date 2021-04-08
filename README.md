# Sentimental-Analysis
 
 * Aim of this aim of this project is to build a sentiment analysis model which will allow us to categorize words based on their sentiments, that is whether they are positive, negative and also the magnitude of it.

** Explanation**

 `install.packages("tidytext")`
 
`install.package("janeaustenR")`

Use of the tidytext package that comprises of sentiment lexicons that are present in the dataset of ‘sentiments’.
For using `Unigrams` , i have used three lexicons AFINN, bing,loughran.
Then retrieving  these lexicons using the get_sentiments() function.
Now  i have imported all libaries  `janeaustenr`, `stringr` as well as `tidytext`.

The janeaustenr package will provide us with the textual data in the form of books authored by the novelist ``Jane Austen``. Tidytext will allow us to perform efficient text analysis on our data.

Using `bing` lexicon to  implement filter() over the words that correspond to joy. I also used the book Sense and Sensibility and derive its words to implement out sentiment analysis model.

**Visualization of function**

`install.packages("ggplot2")`

 Visualizing the words present in the book “Emma” based on their corrosponding positive and negative scores.



** Visualization of Sentiment score**

Plot the scores along the axis that is labeled with both positive as well as negative words. Use ggplot() function to visualize our data based on their scores.




**Final Visualization**

Create a wordcloud that will delineate the most recurring positive and negative words.
Using the comparision.cloud() function to plot both negative and positive words in a single wordcloud.



