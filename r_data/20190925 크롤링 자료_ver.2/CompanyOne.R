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

#필터링 할 단어 사전
filterword <- c('삼성','SDI','현대','모비스','SK','하이닉스','네이버'
                ,'LG','전자','셀트리온','아모레퍼시픽','신세계','KT'
                ,'카카오','에스','오일','한국콜마','콜마','한국','오전'
                ,'오후','올해','지난해','내일','모레','어제','오늘'
                ,'이날','들이','하기','비롯','이번','예정','파이낸셜'
                ,'뉴스','때문','현대모비스','케이','엘지','NAVER','naver'
                ,'만원','에쓰오일','신한','은행','신한은행')


#반복문 시작
repeat{
  #리스트 초기화
  #cloudlist : 워드클라우드용 리스트 / savelist : 뉴스기사 저장용 리스트
  #워드 클라우드는 주식 종목 관련 기사 총 15개에 대한 명사 추출 및 클라우딩
  #뉴스기사 저장용 리스트(savelist)는 주식 종목별 각 언론사에 대한 기사 5개씩
  #크롤링한 기사 내용을 저장 및 utf-8로 인코딩 설정
  cloudlist <- list()
  savelist <- NA
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
  writeLines(savelist[2:6],filename)
  close(filename)
  savelist <- NA
  
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
  writeLines(savelist[2:6],filename)
  close(filename)
  savelist <- NA
  
  #3.조선일보 뉴스에서 해당 종목 관련 기사 5개 크롤링
  site <- read_html(paste0('http://nsearch.chosun.com/search/total.search?query='
                    ,company[com_num],'&cs_search=gnbtotal'),encoding="UTF-8")
  for(i in 4:8){
    tag <- html_nodes(site,paste0('div.search_news_box > dl:nth-child(',i,') > dt > a'))
    url <- html_attr(tag, 'href')  
    
    gotonews <- read_html(url,encoding="UTF-8")
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
  writeLines(savelist[2:6],filename)
  close(filename)
  
  #4.위 3개 언론사에서 받은 기사들을 정제 후 워드클라우딩
  newstext <- gsub('[0-9]',' ',gsub('[[:punct:]]',' ',cloudlist))
  
  text_data <- sapply(newstext,extractNoun,USE.NAMES = F)
  text_data <- Filter(function(x){nchar(x)>=2 & nchar(x)<6},unlist(text_data))
  
  text_df <- data.frame(sort(table(text_data),decreasing = T))
  text_df <- text_df %>% filter(!text_data %in% filterword)
  text_cloud <- wordcloud2(text_df[1:100,],rotateRatio=0
            ,size = 0.5 ,color = "random-dark",backgroundColor = "#ecb")
  
  saveWidget(text_cloud,"cloud.html",selfcontained = F)
  webshot("cloud.html",paste0("cloud_",com_num,".png")
          , delay = 5, vwidth = 800, vheight=500)
  
  com_num <- com_num+1

  if(com_num==length(company)+1){
    break
  }
}
