#Set working directory

setwd("~/Desktop/TwitterR-analysis")


# Install and require twitteR package. 

install.packages("twitteR")

require(twitteR)












#Download the token from here and save it into your work directory:




https://github.com/IARHeritages/Facebook-codes/blob/master/token




#Load the token

load("token")




#Download the pages data from here and save it into your work directory:




https://github.com/IARHeritages/Facebook-codes/blob/master/listPages.R




#Load the data:




load("MexicanBorderPages.R")




#Get the list of ids for a relevant set of pages - set a to a number between 1 and 74.




idsFP <-listPages[[33]]$id




#Set up a list in which to keep the results

my_posts <-c()




#Set up other parameters




np = 100000000

i=1

f=length(idsFP) +1




#start the loop that will go through the list of pages







### If there is an error with Call API just start the loop agai like this:

###Do not reset the parameters (i and my_posts)



while (i<f){
  
  
  
  
  g <- idsFP[i]
  
  j <- getPage(page=g, token=token, n=np, feed=TRUE,since='2010/05/06')
  
  my_posts[[i]] <-j
  
  print (i)
  
  
  
  
  i=i+1
  
}


###After downloading finished, backup save the downloaded posts:

save(my_posts,file="my_postsUSMB(17).R")

