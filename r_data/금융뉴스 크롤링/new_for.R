for(i in 1:20) {
  titleCSS <- paste('body > div > table.type5 > tbody > tr:nth-child(',i,') > td.title > a', sep='')
  title <- remDr$findElements(using='css', titleCSS)
  title_text <- sapply(title ,function(x){x$getElementText()}) 
  title2 <- unlist(title_text)
  if(is.null(title2) == FALSE){
    title_url <- unlist(sapply(title,function(x){x$getElementAttribute('href')}))
    
    title_infoCSS <- paste('body > div > table.type5 > tbody >  tr:nth-child(',i,') > td.info', sep='')
    title_info<-remDr$findElements(using='css', title_infoCSS)
    info <-sapply(title_info,function(x){x$getElementText()})
    info2 <- unlist(info)
    
    title_timeCSS <- paste('body > div > table.type5 > tbody > tr:nth-child(',i,') > td.date', sep='')
    title_time<-remDr$findElements(using='css',title_timeCSS)
    time <-sapply(title_time,function(x){x$getElementText()})
    time2 <- unlist(time)
    
    gotonews <- read_html(title_url,encoding="EUC-KR")
    allnewstext <- NULL
    for(k in 1:20){
      nodes <- html_nodes(gotonews, xpath = paste("//*[@id='news_read']/text()[",k,"]", sep=''))
      newstext<- html_text(nodes)
      newstext<- gsub("\t", "", newstext)
      newstext<- gsub("\n", "", newstext)
      newstext<- gsub("\"", "'", newstext)
      allnewstext<- paste(allnewstext,newstext,sep="")
    }
    allnewstext<-paste(allnewstext,newstext,sep ="") 
    page <-data.frame(title2, info2, time2, allnewstext)
    navereco_info <- rbind(navereco_info,page)
  }
}
