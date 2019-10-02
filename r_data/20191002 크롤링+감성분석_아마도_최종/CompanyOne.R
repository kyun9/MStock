library(RSelenium)
library(stringr)
library(KoNLP)
library(wordcloud2)
library(rvest)
library(dplyr)
library(httr)
library(htmltools)
library(webshot)
library(htmlwidgets)

company <- c('삼성SDI','현대모비스','SK하이닉스','네이버','LG전자'
             ,'셀트리온','아모레퍼시픽','신세계','신한은행','카카오'
             ,'S-Oil','한국콜마')
com_num <- 1

per_df <- data.frame(matrix(nrow=length(company),ncol=2))

#필터링 할 단어 사전
filterword <- c('삼성','SDI','현대','모비스','SK','하이닉스','네이버'
                ,'LG','전자','셀트리온','아모레퍼시픽','신세계','KT'
                ,'카카오','에스','오일','한국콜마','콜마','한국','오전'
                ,'오후','올해','지난해','내일','모레','어제','오늘'
                ,'이날','들이','하기','비롯','이번','예정','파이낸셜'
                ,'뉴스','때문','현대모비스','케이','엘지','NAVER','naver'
                ,'만원','에쓰오일','신한','은행','신한은행')

#감정분석용 긍정 부정 사전 로드
positive <- readLines('positive.txt')[-1]
negative <- readLines('negative.txt')[-1]

#반복문 시작
repeat{
  #리스트 초기화
  #cloudlist : 워드클라우드용 리스트 / savelist : 뉴스기사 저장용 리스트
  #워드 클라우드는 주식 종목 관련 기사 총 15개에 대한 명사 추출 및 클라우딩
  #뉴스기사 저장용 리스트(savelist)는 주식 종목별 각 언론사에 대한 기사 5개씩
  #크롤링한 기사 내용을 저장 및 utf-8로 인코딩 설정
  cloudlist <- list()
  savelist <- c()
  filename <- file()
  
  #1.파이낸셜 뉴스에서 해당 종목 관련 기사 5개 크롤링
  site <- read_html(paste0('http://www.fnnews.com/search?search_txt='
                           ,company[com_num]),encoding="UTF-8")
  for(i in 1:5){
    tag <- html_nodes(site,paste0('#container > div > div 
          > div.section_list > div.bd > ul > li:nth-child(',i,') > span > a'))
    content <- html_text(tag)
    content <- str_trim(unlist(str_split(content
    ,'[-_.+a-zA-Z0-9]+[@].+[.][[a-zA-Z0-9]+|[a-zA-Z0-9]+[.][a-zA-Z0-9]+]'))[1])
    cloudlist <- c(cloudlist,content)
    savelist <- c(savelist,content)
  }
  filename <- file(paste0('파이낸셜_',company[com_num],'.txt'),encoding='UTF-8')
  writeLines(savelist,filename)
  close(filename)
  savelist <- c()
  
  #2.한겨레 뉴스에서 해당 종목 관련 기사 5개 크롤링
  site <- read_html(
    paste0('http://search.hani.co.kr/Search?command=query&keyword='
           ,company[com_num],'&sort=d&period=all&media=news'),encoding="UTF-8")
  for(i in 1:5){
    tag <- html_nodes(site,paste0('#contents > div.search-result-section.first-child > ul > li:nth-child(',i,') > dl > dt > a'))
    url <- html_attr(tag, 'href')
    
    gotonews <- read_html(url,encoding="UTF-8")
    nodes <- html_nodes(gotonews, "div.article-text > div > div.text")
    content <- html_text(nodes)
    
    cloudlist <- c(cloudlist,content)
    savelist <- c(savelist,content)
  }
  filename <- file(paste0('한겨레_',company[com_num],'.txt'),encoding='UTF-8')
  writeLines(str_trim(savelist),filename)
  close(filename)
  savelist <- c()
  
  #3.조선일보 뉴스에서 해당 종목 관련 기사 5개 크롤링
  site <- read_html(paste0('http://nsearch.chosun.com/search/total.search?query='
                    ,company[com_num],'&cs_search=gnbtotal'),encoding="UTF-8")
  for(i in 4:8){
    tag <- html_nodes(site,paste0('div.search_news_box > dl:nth-child(',i,') > dt > a'))
    url <- html_attr(tag, 'href')  
    
    gotonews <- read_html(url)
    nodes <- html_nodes(gotonews, "#news_body_id > div.par")
    content <- html_text(nodes)
    
    if(length(content)!=1){
      newcontent <- ''
      for(index in 1:length(content)){
        newcontent <- paste0(newcontent,content[index])
      }
      content <- newcontent
    }
    
    cloudlist <- c(cloudlist,content)
    savelist <- c(savelist,content)
  }
  filename <- file(paste0('조선일보_',company[com_num],'.txt'),encoding='UTF-8')
  writeLines(str_trim(savelist),filename)
  close(filename)
  
  #4.위 3개 언론사에서 받은 기사들을 정제 후 워드클라우딩
  newstext <- gsub('[0-9]',' ',gsub('[[:punct:]]',' ',cloudlist))
  
  text_data <- sapply(newstext,extractNoun,USE.NAMES = F)
  unlist_text_data <- Filter(function(x){nchar(x)>=2 & nchar(x)<6},unlist(text_data))
  
  text_df <- data.frame(sort(table(unlist_text_data),decreasing = T))
  text_df <- text_df %>% filter(!unlist_text_data %in% filterword)
  text_cloud <- wordcloud2(text_df[1:100,],rotateRatio=0
            ,size = 1 ,color = "random-dark",backgroundColor = "#ecb")
  
  saveWidget(text_cloud,"cloud.html",selfcontained = F)
  webshot("cloud.html",paste0("cloud_",com_num,".png")
          , delay = 5, vwidth = 800, vheight=500)
  
  #5.감성분석
  w_class <- data.frame(matrix(nrow=15, ncol=2))
  names(w_class) <- c("class","news_num")
  
  w_class[,2] <- seq(1,15,1)
  
  pos_vec <- c()
  neg_vec <- c()
  news_word_list <- list()
  
  for(list_num in 1:length(text_data)){
    w_ref <- Filter(function(x){nchar(x)>=1 & nchar(x)<6},text_data[[list_num]])
    
    pos_vec <- Filter(function(x){x %in% positive},w_ref)
    neg_vec <- Filter(function(x){x %in% negative},w_ref)
    
    news_word_list[[list_num]] <- c(pos_vec,neg_vec)
    
    if(length(pos_vec) >= length(neg_vec)){
      w_class[list_num,1] <- "pos"
    }else{
      w_class[list_num,1] <- "neg"
    }
  }
  
  pos_matchsum <- sum(!is.na(match(w_class[,1],'pos')))
  neg_matchsum <- sum(!is.na(match(w_class[,1],'neg')))
  
  p_pos <- pos_matchsum/length(w_class[,1])
  p_neg <- neg_matchsum/length(w_class[,1])
  
  unique_vec <- unique(unlist(news_word_list))
  weight_df <- data.frame(matrix(nrow=15, ncol=length(unique_vec),data = 0))
  names(weight_df) <- unique_vec
  weight_df <- cbind(weight_df,w_class)
  
  for(df_num in 1:length(weight_df[,1])){
    weight_df[df_num,which(names(weight_df) %in%
                             unlist(news_word_list[[df_num]]))] <- 1
  }
  
  tf_idf_df <- data.frame(matrix(nrow=15, ncol=length(unique_vec),data = 0))
  names(tf_idf_df) <- unique_vec
  
  log_df <- data.frame(matrix(nrow=1,ncol=length(unique_vec)))
  names(log_df) <- unique_vec
  
  for(i in 1:length(log_df)){
    log_df[i] <- log(length(text_data)/sum(weight_df[i]))
  }
  
  for(len in 1:length(news_word_list)){
    pos_vec <- Filter(function(x){x %in% positive},unlist(news_word_list[[len]]))
    neg_vec <- Filter(function(x){x %in% negative},unlist(news_word_list[[len]]))
    
    if(length(pos_vec)!=0){
      for(i in 1:length(unique(pos_vec))){
        tf_idf_df[len,unique(pos_vec)[i]] <- 
          (table(pos_vec)/length(w_ref))[unique(pos_vec)[i]]*log_df[unique(pos_vec)[i]]
      }
    }
    
    if(length(neg_vec)!=0){
      for(i in 1:length(unique(neg_vec))){
        tf_idf_df[len,unique(neg_vec)[i]] <- 
          (table(neg_vec)/length(w_ref))[unique(neg_vec)[i]]*log_df[unique(neg_vec)[i]]
      }
    }
  }
  
  tf_idf_df <- cbind(tf_idf_df,w_class)
  df_pos <- tf_idf_df %>% filter(class=='pos')
  df_neg <- tf_idf_df %>% filter(class=='neg')
  
  mean_w_df <- data.frame(matrix(nrow=15, ncol=length(unique_vec),data = 0))
  names(mean_w_df) <- unique_vec
  
  for(i in 1:length(tf_idf_df[,1])){
    for(j in 1:length(unique_vec)){
      if(weight_df[i,j]==1){
        if(weight_df[i,'class']=="pos"){
          mean_w_df[i,j] <- mean(df_pos[,j])
        }else{
          mean_w_df[i,j] <- mean(df_neg[,j])
        }
      }
    }
  }
  
  tf_idf_pos <- mean_w_df[which(tf_idf_df$class=='pos'),]
  tf_idf_neg <- mean_w_df[which(tf_idf_df$class=='neg'),]
  
  tf_idf_pos_sum <- apply(tf_idf_pos,2,sum)
  tf_idf_neg_sum <- apply(tf_idf_neg,2,sum)
  tf_idf_pos_allsum <- sum(tf_idf_pos_sum)
  tf_idf_neg_allsum <- sum(tf_idf_neg_sum)
  
  result_vec <- c()
  result_df <- data.frame(matrix(nrow=15,ncol=2))
  
  for(k in 1:length(news_word_list)){
    pos_doc <- p_pos
    neg_doc <- p_neg
    word_vec <- unlist(news_word_list[[k]])
    if(length(word_vec)==0){
      result_df[k,1] <- pos_doc
      result_df[k,2] <- neg_doc
      if(pos_doc >= neg_doc){
        result_vec <- c(result_vec,'positive')
      }else{
        result_vec <- c(result_vec,'negative')
      }
    }else{
      for(i in 1:length(word_vec)){
        pos_doc <- pos_doc*(tf_idf_pos_sum[word_vec[i]]+1)/
          (tf_idf_pos_allsum+length(unique(word_vec)))
        neg_doc <- neg_doc*(tf_idf_neg_sum[word_vec[i]]+1)/
          (tf_idf_neg_allsum+length(unique(word_vec)))
      }
      result_df[k,1] <- pos_doc
      result_df[k,2] <- neg_doc
      if(pos_doc >= neg_doc){
        result_vec <- c(result_vec,'positive')
      }else{
        result_vec <- c(result_vec,'negative')
      }
    }
  }
  
  mean1 <- mean(result_df$X1)
  mean2 <- mean(result_df$X2)
  
  per1 <- mean1/(mean1+mean2)
  per2 <- mean2/(mean1+mean2)
  
  per_df[com_num,] <- c(per1,per2)

  if(com_num==length(company)){
    break
  }
  com_num <- com_num+1
}
names(per_df) <- c('pos','neg')
per_df*100
