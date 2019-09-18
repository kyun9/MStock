#찾을 주식 종목 이름(이 부분은 Java에서 처리할 예정)
company <- 'LG전자'

#-------------------------------------------------------
library(RSelenium)
library(stringr)
library(KoNLP)
library(wordcloud2)
library(rvest)
library(dplyr)
library(httr)

#필터링 할 단어 사전
filterword <- c('삼성','전자','현대','모비스','SK','이노베이션'
                ,'LG','전자','롯데','그룹','오전','오후','올해','지난해'
                ,'내일','모레','어제','오늘','이날','들이','하기','비롯'
                ,'이번','예정','파이낸셜','뉴스','때문')

#리스트 초기화
list <- list()


#1.파이낸셜 뉴스에서 해당 종목 관련 기사 5개 크롤링
site <- read_html(paste0('http://www.fnnews.com/search?search_txt='
                         ,company),encoding="UTF-8")
for(i in 1:5){
  tag <- html_nodes(site,paste0('#container > div > div 
          > div.section_list > div.bd > ul > li:nth-child(',i,') > span > a'))
  content <- html_text(tag)
  list <- c(list,content)
}


#2.한겨레 뉴스에서 해당 종목 관련 기사 5개 크롤링
site <- read_html(
        paste0('http://search.hani.co.kr/Search?command=query&keyword='
               ,company,'&sort=d&period=all&media=news'),encoding="UTF-8")
for(i in 1:5){
  tag <- html_nodes(site,paste0('#contents > div.search-result-section.first-child > ul > li:nth-child(',i,') > dl > dt > a'))
  url <- html_attr(tag, 'href')
  
  gotonews <- read_html(url,encoding="UTF-8")
  nodes <- html_nodes(gotonews, "#a-left-scroll-in > div.article-text 
                    > div > div.text")
  content <- html_text(nodes)
  list <- c(list,content)
}


#3.중앙일보 뉴스에서 해당 종목 관련 기사 5개 크롤링
site <- read_html(paste0('https://search.joins.com/JoongangNews?Keyword='
        ,company,'&SortType=New&SearchCategoryType=JoongangNews&PeriodType=All&ScopeType=All&ImageType=All&JplusType=All&BlogType=All&ImageSearchType=Image&TotalCount=0&StartCount=0&IsChosung=False&IssueCategoryType=All&IsDuplicate=True&Page=1&PageSize=10&IsNeedTotalCount=True')
        ,encoding="UTF-8")
for(i in 1:5){
  tag <- html_nodes(site,paste0('#content > div.section_news > div.bd > ul > li:nth-child(',i,') > div > h2 > a'))
  url <- html_attr(tag, 'href')  
  
  gotonews <- read_html(url,encoding="UTF-8")
  nodes <- html_nodes(gotonews, "#article_body")
  content <- html_text(nodes)
  list <- c(list,content)
}


#4.위 3개 언론사에서 받은 기사들을 정제 후 워드클라우딩
newstext <- str_sub(str_trim(
  gsub('[-_.+a-zA-Z0-9]+[@].+[.][[a-zA-Z0-9]+|[a-zA-Z0-9]+[.][a-zA-Z0-9]+]'
       ,'',list)),1,-8)
newstext <- gsub('[0-9]',' ',gsub('[[:punct:],[:space:]]',' ',newstext))

text_data <- sapply(newstext,extractNoun,USE.NAMES = F)
text_data <- Filter(function(x){nchar(x)>=2 & nchar(x)<6},unlist(text_data))

text_df <- data.frame(sort(table(text_data),decreasing = T))
text_df <- text_df %>% filter(!text_data %in% filterword)
wordcloud2(text_df[1:100,],rotateRatio=0)
