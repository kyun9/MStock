#임시 파일
#네이버에서 검색 후 필터링,기사 하나만 추출하는 것까지만 함

library(RSelenium)
library(dplyr)
##library(XML)
library(httr)
library(rvest)
library(KoNLP)
library(stringr)
library(wordcloud2)

remDr <-remoteDriver(remoteServerAddr = "localhost"
                     , port=4445, browserName = "chrome")
remDr$open()

#네이버 뉴스 삼성전자 검색 및 기간 1일
site <- paste0('https://search.naver.com/search.naver?where=news
               &query=','삼성전자','&pd=4')
remDr$navigate(site)

#언론사 필터림 및 클릭 이벤트
newspopup <- remDr$findElements(using='css','#news_popup > a') # 언론사 버튼
press1 <- remDr$findElements(using='css','#ca_1014') # 파이낸셜
press2 <- remDr$findElements(using='css','#ca_1025') # 중앙
press3 <- remDr$findElements(using='css','#ca_1028') # 한겨레
confirm <- remDr$findElements(using='css','#_nx_option_media > div.con_bx 
                              > div.view_btn > button.impact._submit_btn 
                              > span') # 필터링 지정 후 누를 확인 버튼

#파이낸셜 클릭
sapply(newspopup,function(x){x$clickElement()})
sapply(press1,function(x){x$clickElement()})
sapply(confirm,function(x){x$clickElement()})

#파이낸셜 크롤링 끝냈을 때, 중앙일보 크롤링 하기 위한 필터링 재지정
sapply(newspopup,function(x){x$clickElement()})
sapply(press1,function(x){x$clickElement()})
sapply(press2,function(x){x$clickElement()})
sapply(confirm,function(x){x$clickElement()})

#중앙일보 크롤링 끝냈을 때, 한겨레 크롤링 하기 위한 필터링 재지정
sapply(newspopup,function(x){x$clickElement()})
sapply(press2,function(x){x$clickElement()})
sapply(press3,function(x){x$clickElement()})
sapply(confirm,function(x){x$clickElement()})

#기사 제목의 url을 받아온 뒤 해당 url의 뉴스기사 크롤링
title <- remDr$findElements(using='css','#sp_nws1 > dl > dt > a')
url <- unlist(sapply(title,function(x){x$getElementAttribute('href')}))

#아래 예시는 파이낸셜 뉴스 기사 중 1개 크롤링해본 것
#중앙일보,한겨레는 추후 시도한 뒤 통합할 예정
gotonews <- read_html(url,encoding="UTF-8")
nodes <- html_nodes(gotonews, "#article_content")
newstext <- html_text(nodes)

#받아온 기사 내용의 이메일,~~~기자 등을 제거
newstext <- str_sub(str_trim(
  gsub('[-_.+a-zA-Z0-9]+[@].+[.][[a-zA-Z0-9]+|[a-zA-Z0-9]+[.][a-zA-Z0-9]+]'
       ,'',newstext)),1,-7)
#위 내용에서 필요 없는(공백 및 특수문자,숫자) 제거
newstext <- gsub('[0-9]','',gsub('[[:punct:],[:space:]]',' ',newstext))
#정제된 기사 내용에 대해 명사 추출 및 선택할 단어 길이 조정
text_data <- sapply(newstext,extractNoun,USE.NAMES = F)
text_data <- Filter(function(x){nchar(x)>=2 & nchar(x)<6},text_data)
#단어 빈도수가 많은 순으로 정렬
#검색할 때 사용한 키워드가 삼성전자 였으므로 
#삼성 이라는 단어를 제외한 단어 빈도수 중 상위 30개만 워드 클라우드
text_table <- sort(table(text_data),decreasing = T)
wordcloud2(text_table[names(text_table)!='삼성'][1:30],rotateRatio = 0)




#---------------------------------------------------------------------
#이 구역은 안 쓸듯
#크롤링시 사이트로 들어가서 크롤링을 하려 했으나
#새 창에서 띄워지면 크롤링 실행이 제대로 안됌

#검색 결과 첫 번째 기사 제목
title <- remDr$findElements(using='css','#sp_nws1 > dl > dt > a')
sapply(title,function(x){x$clickElement()})

#해당 기사 내용 크롤링
text <- remDr$findElements(using='css','#article_content 
                           > div.aricle_subtitle')
list <- sapply(text,function(x){x$getElementText()})

#새창 띄우기 전 네이버 검색한 창에서 text 크롤링 되는지 실험해본것(쓸데 없음)
text2 <- remDr$findElements(using='css','#sp_nws1 > dl > dd:nth-child(3)')
list2 <- sapply(text2,function(x){x$getElementText()})
#---------------------------------------------------------------------
