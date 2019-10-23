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
library(Rserve)
library(RColorBrewer)
library(jsonlite)

company <- c('삼성SDI','현대모비스','SK하이닉스','NAVER','LG전자'
             ,'셀트리온','아모레퍼시픽','신세계','신한은행','카카오'
             ,'S-Oil','한국콜마')

com_code <- c('006400','012330','000660','035420'
              ,'066570','068270','090430','004170'
              ,'055550','035720','010950','161890')

com_num <- 1

per_reg_df <- data.frame(matrix(nrow=5,ncol=12)
                         ,row.names=c('name','pos','neg','pred_val','pred_per'))

#필터링 할 단어 사전
filterword <- c('삼성','SDI','현대','모비스','SK','하이닉스','네이버'
                ,'LG','전자','셀트리온','아모레퍼시픽','신세계','KT'
                ,'카카오','에스','오일','한국콜마','콜마','한국','오전'
                ,'오후','올해','지난해','내일','모레','어제','오늘'
                ,'이날','들이','하기','비롯','이번','예정','파이낸셜'
                ,'뉴스','때문','현대모비스','케이','엘지','NAVER','naver'
                ,'만원','에쓰오일','신한','은행','신한은행'
                ,'co','kr','com','www','https','http','hani')

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
  if(com_num==11){
    newstext <- str_trim(gsub('[^가-힣]',' ',newstext))
    newstext <- Filter(function(x){nchar(x)!=0},newstext)
  }
  newstext <- Filter(function(x){nchar(x)<10000},newstext)
  text_data <- sapply(newstext,extractNoun,USE.NAMES = F)
  unlist_text_data <- Filter(function(x){nchar(x)>=2 & nchar(x)<6},unlist(text_data))
  
  text_df <- data.frame(sort(table(unlist_text_data),decreasing = T))
  text_df <- text_df %>% filter(!unlist_text_data %in% filterword)
  
  size_num <- text_df[1,2]/text_df[100,2]/15
  if(size_num < 0.45){
    size_num <- size_num+0.1
  }
  text_cloud <- wordcloud2(text_df[1:100,],rotateRatio=0
                           ,fontFamily = '나눔스퀘어라운드'
                           ,size = size_num
                           ,color = rep_len(brewer.pal(9,"Blues")[9:5]
                                            ,nrow(text_df[1:100,])))
  
  saveWidget(text_cloud,"cloud.html",selfcontained = F)
  webshot("cloud.html",paste0(company[com_num],".png")
          , delay = 5, vwidth = 800, vheight=500)
  
  #5.감성분석
  
  #5-1.초기 클래스(긍정,부정) 분류를 위한 데이터 프레임 생성 및 클래스 분류
  w_class <- data.frame(matrix(nrow=length(text_data), ncol=2))
  names(w_class) <- c("class","news_num")
  
  w_class[,2] <- seq(1,length(text_data),1)
  
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
  
  #5-2.긍정 부정 분류한 뒤 계산
  #p_pos , p_neg : 15개 기사 중 긍정,부정으로 나뉜 기사의 비율
  pos_matchsum <- sum(!is.na(match(w_class[,1],'pos')))
  neg_matchsum <- sum(!is.na(match(w_class[,1],'neg')))
  
  p_pos <- pos_matchsum/length(w_class[,1])
  p_neg <- neg_matchsum/length(w_class[,1])
  
  #5-3.각 기사 별 존재하는 단어 체크를 위한 데이터 프레임 생성 및 분류
  #기사에 존재하는 단어는 1, 없는 단어는 0으로 지정
  #위에서 분류한 긍,부정 클래스를 weight_df 에 붙여줌
  unique_vec <- unique(unlist(news_word_list))
  weight_df <- data.frame(matrix(nrow=length(text_data)
                                 , ncol=length(unique_vec),data = 0))
  names(weight_df) <- unique_vec
  weight_df <- cbind(weight_df,w_class)
  
  for(df_num in 1:length(weight_df[,1])){
    weight_df[df_num,which(names(weight_df) %in%
                             unlist(news_word_list[[df_num]]))] <- 1
  }
  
  #5-4.각 기사 별 tf 값을 구하기 위한 데이터 프레임 생성 및 계산
  #idf = log(전체기사/단어 존재기사) 값을 데이터 프레임으로 생성 및 계산
  #이후 두 프레임의 값에 대해 곱 계산
  tf_idf_df <- data.frame(matrix(nrow=length(text_data)
                                 , ncol=length(unique_vec),data = 0))
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
  
  #5-5.tf_idf_df 를 클래스별로 구분하기 위해 클래스를 붙인 뒤 2개로   나눔
  #긍정,부정일때 각각의 평균 값을 넣어주는 과정 실행
  tf_idf_df <- cbind(tf_idf_df,w_class)
  df_pos <- tf_idf_df %>% filter(class=='pos')
  df_neg <- tf_idf_df %>% filter(class=='neg')
  
  mean_w_df <- data.frame(matrix(nrow=length(text_data)
                                 ,ncol=length(unique_vec),data = 0))
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
  
  #5-6.mean_w_df(긍,부정 각각의 가중치 평균을 넣어준 데이터 프레임)
  #이를 이용해 다시 클래스별로 분류 후 긍,부정 별 열별 합과 전체합을 구함
  #이는 나이브 베이즈 분류기 적용을 위한 절차
  tf_idf_pos <- mean_w_df[which(tf_idf_df$class=='pos'),]
  tf_idf_neg <- mean_w_df[which(tf_idf_df$class=='neg'),]
  
  tf_idf_pos_sum <- apply(tf_idf_pos,2,sum)
  tf_idf_neg_sum <- apply(tf_idf_neg,2,sum)
  tf_idf_pos_allsum <- sum(tf_idf_pos_sum)
  tf_idf_neg_allsum <- sum(tf_idf_neg_sum)
  
  #5-7.결과값을 저장하기 위한 벡터 및 데이터 프레임 생성
  #벡터에는 단순 긍정,부정을 넣어줌 @@(필요한지 잘 모르겠음)@@
  #데이터 프레임에는 나이브 베이즈 분류기 값을 저장
  result_vec <- c()
  result_df <- data.frame(matrix(nrow=length(text_data),ncol=2))
  
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
  
  #5-8.결과 값을 도출한 result_df에서 평균값과 비율을 구함
  #per_df에 per1과 per2를 넣어줌
  # = 주식 종목12개에 대해서 각각의 15개의 기사에 대한
  #   긍,부정에 대한 비율을 넣어줌
  mean1 <- mean(result_df$X1)
  mean2 <- mean(result_df$X2)
  
  per1 <- 100*mean1/(mean1+mean2)
  per2 <- 100*mean2/(mean1+mean2)
 
  #6.회귀분석 
  json_df <- fromJSON(paste0(path,com_code[com_num],".json"))
  
  info_df <- data.frame(matrix(ncol=4,nrow=0))
  
  bef_time <- format(Sys.time()-3600,'%Y/%b/%d %H:%M')
  aft_time <- format(Sys.time(),'%Y/%b/%d %H:%M')
  
  for(i in 1:length(json_df$Stockinfo)){
    if(str_sub(json_df$gettime[i],1,16)>bef_time
       &str_sub(json_df$gettime[i],1,16)<aft_time){
      info_df <- rbind(info_df,c(json_df$Stockinfo[[i]][2]
                                 ,json_df$Stockinfo[[i]][6]
                                 ,str_sub(json_df$gettime[i],15,16)
                                 ,str_sub(json_df$gettime[i],18,19))
                       ,stringsAsFactors=F)
    }
  }
  info_df[] <- lapply(info_df, function(x) as.numeric(gsub(",", "", x)))
  info_df <- cbind(info_df[,1:2],(info_df[,3]*60+info_df[,4])/60)
  names(info_df) <- c('marketprice','volume','time')
  
  model <- lm(marketprice~.,data=info_df)
  reg_result <- summary(model)
  
  beta0 <- reg_result$coefficients[1]
  beta1 <- reg_result$coefficients[2]
  beta2 <- reg_result$coefficients[3]
  
  x1 <- info_df$volume[length(info_df$volume)]+
    ((info_df$volume[length(info_df$volume)]-info_df$volume[1])/6)
  x2 <- 70
  
  pred_val <- round(beta0+beta1*x1+beta2*x2,digits=-1)
  pred_per <- round(reg_result$adj.r.squared*100,digits=1)
  
  per_reg_df[,com_num] <- c(company[com_num],round(per1,1),round(per2,1)
                            ,pred_val,pred_per)
  
  if(com_num==length(company)){
    break
  }
  com_num <- com_num+1
}

per_reg_df
