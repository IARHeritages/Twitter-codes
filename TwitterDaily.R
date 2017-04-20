### The code was developed as part of the IARH project
### Project IARH
### Author Chiara Bonacchi

#Set working directory

setwd("~/Desktop/TwitterScrapes_Brexit/Brexit")


# Install and require twitteR package. 

install.packages("twitteR")

require(twitteR)

setup_twitter_oauth(consumer_key="enter", consumer_secret="enter", access_token="enter", access_secret="enter")

romanempire <- searchTwitter('#romanempire', n=1500)

romanempire <- twListToDF(romanempire)

write.csv(romanempire, file = "romanempire.csv", row.names = FALSE)

###TO BE CONTINUED

Create script to be launched daily which extracts 1500 per hashtag for relevant hashtags (perdio-specific) and run for a month
