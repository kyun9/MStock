package rtest;


import org.rosuda.REngine.RList;
import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.stereotype.Service;
@Service
public class NewsService  {	
	public String returnNews1(String code)  {
		RConnection r = null;
		String retStr = "";
		String[][] news_info = new String[10][3]; 
		try {
			r = new RConnection(); 
			r.eval("library(RSelenium)");
			r.eval("library(dplyr)");
			r.eval("library(XML)");
			r.eval("library(RCurl)"); 
			r.eval("library(rvest)");
			r.eval("library(httr)");
			r.eval("library(tidyverse)");
			r.eval("library(Rserve)");
			r.eval("library(rvest)");
			
			r.eval("remDr <-remoteDriver(remoteServerAddr = \"localhost\" , port=4445, browserName = \"chrome\")");
			r.eval("remDr$open()");
			r.eval("code = '"+code+"'");
			r.eval("url <- paste(\"https://finance.naver.com/item/news_news.nhn?code=\",code, sep=\"\")");
			r.eval("remDr$navigate(url)");
			r.eval("navereconomic_contents<-NULL");
			r.eval("navereco_info<-NULL");
			r.eval("source('c:/Rstudy/new_for.R')");
			RList list = r.eval("navereco_info").asList(); 
		    System.out.println(list.at(1).asStrings());
			String[][]s = new String[3][10];
			for(int i=0; i<3; i++) {
				s[i] = list.at(i).asStrings();				
			}
			for(int j=0; j<10; j++) {
				for(int i=0; i<3; i++) {
					news_info[j][i] = s[i][j];
					retStr += (news_info[j][i]);
				}
				retStr += "</br>";
				
			}	
			System.out.println(retStr);
//				retStr += "</br>";
//			}
//			String fileName = path + "/index.html";
//			System.out.println(fileName);
//			r.eval("'"+fileName+"',  selfcontained = F)");
//			retStr = r.eval("'index.html'").asString();
		} catch (Exception e) {
			System.out.println(e);
			retStr = "오류 발생!!";
		} finally {
			r.close(); 
		}
		return retStr;
	}	
}