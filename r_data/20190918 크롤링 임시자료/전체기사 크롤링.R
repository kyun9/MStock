library(RSelenium)
library(stringr)
library(KoNLP)
library(wordcloud2)
library(rvest)
library(dplyr)

#필터링 할 단어 사전
filterword <- c('삼성','전자','현대','모비스','SK','이노베이션'
                ,'LG','전자','롯데','그룹','오전','오후','올해','지난해'
                ,'내일','모레','어제','오늘','이날','들이','하기','비롯'
                ,'이번','예정','파이낸셜','뉴스','때문')

#주식 종목 10개를 벡터형으로 만들기(현재 임시로 5개만 함)
company <- c('삼성전자','현대모비스','SK이노베이션','LG전자','롯데그룹')

#리스트 초기화
list <- list()

#각 언론사별 주식 종목에 대한 기사 5개씩
#즉 10개 기업,3개 언론사에서 기사 5개씩 = 총 150개 크롤링
#현재 이 코드는 주식 종목을 임시로 5개 지정했으므로 총 75개
com_num <- 1
press <- 0
repeat{
  if(press==0){
    repeat{
      site <- read_html(paste0('http://www.fnnews.com/search?search_txt='
                               ,company[com_num]),encoding="UTF-8")
      for(i in 1:5){
        tag <- html_nodes(site,paste0('#container > div > div 
          > div.section_list > div.bd > ul > li:nth-child(',i,') > span > a'))
        content <- html_text(tag)
        list <- c(list,content)
      }
      com_num <- com_num +1
      if(com_num==6){
        com_num <- 1
        break
      }
    }
  }else if(press==1){
    repeat{
      site <- read_html(
        paste0('http://search.hani.co.kr/Search?command=query&keyword='
               ,company[com_num],'&sort=d&period=all&media=news')
        ,encoding="UTF-8")
      for(i in 1:5){
        tag <- html_nodes(site,paste0('#contents > div.search-result-section.first-child > ul > li:nth-child(',i,') > dl > dt > a'))
        url <- html_attr(tag, 'href')
        
        gotonews <- read_html(url,encoding="UTF-8")
        nodes <- html_nodes(gotonews, "#a-left-scroll-in > div.article-text 
                    > div > div.text")
        content <- html_text(nodes)
        list <- c(list,content)
      }
      com_num <- com_num+1
      if(com_num==6){
        com_num <- 1
        break
      }
    }
  }else if(press==2){
    repeat{
      site <- read_html(
        paste0('https://search.joins.com/JoongangNews?Keyword=',company[com_num],'&SortType=New&SearchCategoryType=JoongangNews&PeriodType=All&ScopeType=All&ImageType=All&JplusType=All&BlogType=All&ImageSearchType=Image&TotalCount=0&StartCount=0&IsChosung=False&IssueCategoryType=All&IsDuplicate=True&Page=1&PageSize=10&IsNeedTotalCount=True')
        ,encoding="UTF-8")
      for(i in 1:5){
        tag <- html_nodes(site,paste0('#content > div.section_news > div.bd > ul > li:nth-child(',i,') > div > h2 > a'))
        url <- html_attr(tag, 'href')  
        
        gotonews <- read_html(url,encoding="UTF-8")
        nodes <- html_nodes(gotonews, "#article_body")
        content <- html_text(nodes)
        
        list <- c(list,content)
      }
      com_num <- com_num+1
      if(com_num==6){
        break
      }
    }
  }
  press <- press+1
  if(press==3){
    break
  }
}


#-----------------------------------------------------------
#정제 작업이 필요한지 모르겠음.(하둡 저장용) 이 부분은 의논점
newstext <- str_sub(str_trim(
  gsub('[-_.+a-zA-Z0-9]+[@].+[.][[a-zA-Z0-9]+|[a-zA-Z0-9]+[.][a-zA-Z0-9]+]'
       ,'',list)),1,-8)
newstext <- gsub('[0-9]',' ',gsub('[[:punct:],[:space:]]',' ',newstext))

text_data <- sapply(newstext,extractNoun,USE.NAMES = F)
text_data <- Filter(function(x){nchar(x)>=2 & nchar(x)<6},unlist(text_data))

text_df <- data.frame(sort(table(text_data),decreasing = T))
text_df <- text_df %>% filter(!text_data %in% filterword)
wordcloud2(text_df[1:30,],rotateRatio=0)
