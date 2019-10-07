library(dplyr)
library(XML)
library(RCurl)
library(rvest)
library(httr)
library(Rserve)
library(stringr)

##Rserve(args="--RS-encoding utf8")

navereco_info<-NULL

  url <- read_html(paste("https://finance.naver.com/item/news_news.nhn?code="
                         ,code, sep=""))
  for(i in 1:20) {
    titleCSS <- paste('body > div > table.type5 > tbody > tr:nth-child('
                      ,i,') > td.title > a', sep='')
    title_node <- html_nodes(url,titleCSS)
    title <- html_text(title_node)
    title
    if(length(title)==1){
      title_url <- html_attr(title_node,'href')
      
      title_infoCSS <- paste('body > div > table.type5 > tbody > tr:nth-child(',i,') > td.info', sep='')
      title_info <- html_nodes(url,title_infoCSS)
      info <- html_text(title_info)
      
      title_timeCSS <- paste('body > div > table.type5 > tbody > tr:nth-child(',i,') > td.date', sep='')
      title_time <- html_nodes(url,title_timeCSS)
      time <- str_trim(html_text(title_time))
      
      gotonews <- read_html(paste0('https://finance.naver.com',title_url)
                            ,encoding="EUC-KR")
      allnewstext <- NULL
      for(k in 1:20){
        nodes <- html_nodes(gotonews, xpath = paste("//*[@id='news_read']/text()[",k,"]", sep=''))
        newstext<- html_text(nodes)
        newstext<- gsub("\t", "", newstext)
        newstext<- gsub("\n", "", newstext)
        newstext<- gsub("\"", "'", newstext)
        allnewstext<- paste(allnewstext,newstext,sep="")
      }
      page <-data.frame(title, info, time,allnewstext)
      navereco_info <- rbind(navereco_info,page)
    }
  }
  