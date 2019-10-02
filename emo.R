library(RSelenium)
library(dplyr)
library(wordcloud2)
library(ggplot2)
library(XML)
library(RCurl)
library(stringr)
library(dplyr)
remDr <-remoteDriver(remoteServerAddr = "localhost" , port=4445, browserName = "chrome")
remDr$open()
company <- '삼성'
press <- 'www.hani.co.kr'
site <- paste('https://www.google.com/search?q=',company,'+site:',press,'&safe=active&tbm=nws&sxsrf=ACYBGNRi6U2AWp1XiefktJcXw25MYJMazQ:1568611258313&source=lnt&tbs=qdr:h&sa=X&ved=0ahUKEwi6q96mzNTkAhWFw4sBHXN2DzsQpwUIHw&biw=1280&bih=913&dpr=1', sep='')
remDr$navigate(site)
webElem <- remDr$findElement("css", "body")
fullContentCSS <- paste('#header > div.head > div.btn_searchDetail > a > img')
fullContent<-remDr$findElements(using='css', fullContentCSS)
sapply(fullContent,function(x){x$clickElement()})
 
 
  positive<- readLines("positive.txt",encoding = "UTF-8")
  positive=positive[-1]  
  negative <- readLines("negative.txt",encoding = "UTF-8")
  negative=negative[-1]  
  sentimental = function(imsi4,positive,negative){
    score = laply(imsi4,function(imsi4,positive,negative){
      remDr <-remoteDriver(remoteServerAddr = "localhost" , port=4445, browserName = "chrome")
      remDr$open()
      com_name <- NULL
      site <- paste("http://www.fnnews.com/news/201909101806035730")
      remDr$navigate(site)
      fullContentCSS <- paste('//*[@id="article_content"]')
      fullContent<-remDr$findElements(using='xpath', fullContentCSS)
      imsi <- sapply(fullContent,function(x){x$getElementText()})
      imsi2 <- gsub("[[:punct:]]", "", imsi)
      imsi2 <- gsub("\\d+", "", imsi2)
      imsi3 <- sapply(imsi2, extractNoun, USE.NAMES = F)
      imsi4<- Filter(function(x){nchar(x) >= 2}, imsi3)
      
      pos.matchs = match(imsi4,positive)
      neg.matchs = match(imsi4,negative)
      
      pos.matchs = !is.na(pos.matchs)
      neg.matchs = !is.na(pos.matchs)
      
      score = sum(pos.matchs) - sum(neg.matchs)
      return(score ,sum(pos.matchs),sum(neg.matchs))
    }, positive, negative)
    scroes.df = data.frame(score=score, text= "삼성")
  }  
  