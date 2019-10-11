
# company <- c('삼성SDI','현대모비스','SK하이닉스','네이버','LG전자'
#              ,'셀트리온','아모레퍼시픽','신세계','신한은행','카카오'
#              ,'S-Oil','한국콜마')
# install.packages("jsonlite")

library(jsonlite)
library(stringr)
library(Rserve)

json_df <- fromJSON(paste0(path,code,".json"))
  
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

result <- data.frame(matrix(nrow=2,ncol=1))
names(result) <- 'result'
result[1,1] <- round(beta0+beta1*x1+beta2*x2,digits=-1)
result[2,1] <- round(reg_result$adj.r.squared*100,digits=1)

result
