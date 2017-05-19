### The code was developed as part of the IARH project
### Project IARH
### Author Chiara Bonacchi

##Set working directory
setwd("~/Desktop/Brexit-Twitter-Analysis")

##Install and require R package for Twitter data extraction and analysis, and TM package
install.packages("twitteR")
require(twitteR)
install.packages("tm")
require(tm)

##Import csv file containing the data that has been extracted (in this case containing the words 'Brexit' and other period-specific keywords)
MyData <- read.csv(file="~/Desktop/Brexit-Twitter-Analysis/TOTAL-Brexit.csv", header=TRUE, sep=",")

##Have a look at column names in the dataframe 'MyData' and 
names(MyData)

##Check that all tweets are unique and have a look at the content
tweets <- (MyData$Tweet)
length(uniquetweets))
head(tweets)

##Create corpus object made of mined tweets contained in 'MyData'
a <- Corpus(VectorSource(tweets))

##Remove odd characters from corpus
a <- tm_map(a, function(x) iconv(x, to='UTF-8-MAC', sub='byte'))

##Bring all characters to lower case, remove punctuation and numbers from corpus, remove common stopwords in English from corpus
a <- tm_map(a, tolower)
a <- tm_map(a, removePunctuation)
a <- tm_map(a, removeNumbers)
a <- tm_map(a, removeWords, stopwords("english"))

##Require rJava and SnowballC for stemming and transform terms into tokens
require(rJava)
install.packages("SnowballC")
require(Snowball)
a <- tm_map(a, stemDocument, language="english")

##Create a Document Term Matrix with terms longer than 3 letters and have a quick look
a.dtm <- TermDocumentMatrix(a, control=list(minWordLength=3))
inspect(a.dtm[1:10, 1:10])

##Find common words (appearing at least 30/50/200/300/400 times in the corpus), and crearte csv files for exchange.
setwd("~/Desktop/Brexit-Twitter-Analysis/Most-frequent-tokens")

freqterms <- findFreqTerms(a.dtm, lowfreq = 30)
write.csv(freqterms, file="freqterms30.csv")

freqterms <- findFreqTerms(a.dtm, lowfreq = 50)
write.csv(freqterms, file="freqterms50.csv")

freqterms <- findFreqTerms(a.dtm, lowfreq = 100)
write.csv(freqterms, file="freqterms100.csv")

freqterms <- findFreqTerms(a.dtm, lowfreq = 150)
write.csv(freqterms, file="freqterms150.csv")

freqterms <- findFreqTerms(a.dtm, lowfreq = 175)
write.csv(freqterms, file="freqterms175.csv")

freqterms <- findFreqTerms(a.dtm, lowfreq = 200)
write.csv(freqterms, file="freqterms200.csv")

freqterms <- findFreqTerms(a.dtm, lowfreq = 300)
write.csv(freqterms, file="freqterms300.csv")

freqterms <- findFreqTerms(a.dtm, lowfreq = 500)
write.csv(freqterms, file="freqterms500.csv")

##Identify and remove additional stopwords, after looking at the outputs returned by the findFreqTerms function.
setwd("~/Desktop/Brexit-Twitter-Analysis")
myStopwords <- c(stopwords('english'),"via", "like", "just", "cant", "that", "will", "much", "wont", "dont", "even", "yes", "right", "yet", "didnt", "tri")
a <- tm_map(a, removeWords, myStopwords)
a <- tm_map(a, stemDocument, language="english")
a.dtm <- TermDocumentMatrix(a, control=list(minWordLength=3))
  
##Find tokens associated to the most common words - those recurring at least 150 times.
findAssocs2 <- findAssocs(a.dtm, c("brexit", "back", "new", "vote", "now", "roman", "age", "dark", "empir", "britain", "scotland", "mediev", "celtic", "barbarian", "trump", "take", "europ", "time", "barbar", "want", "middl", "celtic", "caesar"), 0.10)

##Look-up URLs contained in tweets
str_extract(tweets, "http[[:print:]]+") -> urls
urls.list <- data.frame(URL=as.character(unlist(dimnames(sort(table(urls))))))
write.csv(urls.list, "urls.list.csv")
  
  
  
###TO BE CONTINUED - ANALYSIS IN PRROGRESS
