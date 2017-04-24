### The code was developed as part of the IARH project
### Project IARH
### Author Chiara Bonacchi

##Set working directory
setwd("~/Desktop/Brexit tweets manipulated")

##Install and require R package for Twitter data extraction and analysis, and TM package
install.packages("twitteR")
require(twitteR)
install.packages("tm")
require(tm)

##Import csv file containing the data that has been extracted (in this case containing the words 'Brexit' and other period-specific keywords)
MyData <- read.csv(file="~/Desktop/Brexit tweets manipulated/TOTAL-Brexit.csv", header=TRUE, sep=",")

##Have a look at column names in the dataframe 'MyData' and 
names(MyData)

##Check that all tweets are unique and have a look at the content
tweets <- (MyData$Tweet)
length(unique(MyData$Tweet))
head(MyData)

##Create corpus object made of mined tweets contained in 'MyData'
a <- Corpus(VectorSource(MyData$Tweet))

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
require(Snawball)
a <- tm_map(a, stemDocument, language="english")

##Create a Document Term Matrix with terms longer than 3 letters and have a quick look
a.dtm <- TermDocumentMatrix(a, control=list(minWordLength=3))
inspect(a.dtm[1:10, 1:10])

##Find common words (appearing at least 30/50/200/300/400 times in the corpus), and crearte csv files for exchange.
freqterms <- findFreqTerms(a.dtm, lowfreq = 30)
write.csv(freqterms, file="freqterms30.csv")

freqterms <- findFreqTerms(a.dtm, lowfreq = 50)
write.csv(freqterms, file="freqterms30.csv")

freqterms <- findFreqTerms(a.dtm, lowfreq = 200)
write.csv(freqterms, file="freqterms200.csv")

freqterms <- findFreqTerms(a.dtm, lowfreq = 300)
write.csv(freqterms, file="freqterms300.csv")

freqterms <- findFreqTerms(a.dtm, lowfreq = 450)
write.csv(freqterms, file="freqterms450.csv")

##Find tokens associated to the most common words
findAssocs2 <- findAssocs(a.dtm, c("brexit", "celtic", "dark", "barbarian", "barbar"), 0.10)
