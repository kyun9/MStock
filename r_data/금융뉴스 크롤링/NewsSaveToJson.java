package rjava;


import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.rosuda.REngine.RList;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;

public class NewsCreate{
	
	public static void createNews(){
		RConnection r = null;
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd-HH-mm"); //파일명을 현재 연도-월-일-시-분으로 설정
		Configuration conf = new Configuration();
		conf.set("fs.defaultFS", "hdfs://192.168.111.120:9000");
		String[] code = {"006400", "000660", "012330", "035420", "066570", "068270", "090430", "004170","055550","035720","010950","161890"};
		String FileName = format1.format (System.currentTimeMillis());
			try {
			r = new RConnection(); 
			r.eval("library(RSelenium)");
			r.eval("library(dplyr)");
			r.eval("library(XML)");
			r.eval("library(RCurl)"); 
			r.eval("library(rvest)");
			r.eval("library(httr)");
			r.eval("library(tidyverse)");
			r.eval("library(rvest)");
			r.eval("remDr <-remoteDriver(remoteServerAddr = \"localhost\" , port=4445, browserName = \"chrome\")");
			r.eval("remDr$open()");
			String Json = "{\"all\":"+"[" ;
			for(int h = 0; h< code.length ;h++) {	
			Json += "{\"code\":"+"\""+code[h]+"\",\"news\":[";
			r.eval("code = '"+code[h]+"'");
			r.eval("url <- paste(\"https://finance.naver.com/item/news_news.nhn?code=\",code, sep=\"\")");
			r.eval("remDr$navigate(url)");
			r.eval("navereconomic_contents<-NULL");
			r.eval("navereco_info<-NULL");
			r.eval("source('c:/Rstudy/new_for.R')");
			RList list = r.eval("navereco_info").asList();
		
			// 파일을 바꿀 필요가 없음 바로 출력할 필요가 없음
			String[][]s = new String[4][10];
			for(int i=0; i<4; i++) {
				s[i] = list.at(i).asStrings();
			}
			for(int j=0; j<10; j++) {
				   //json위치별 저장
				    s[0][j] = s[0][j].replace("\"","");
					Json += "{\"title\":"+"\""+s[0][j]+"\","+
							  "\"press\":"+"\""+s[1][j]+"\","+
							  "\"time\":"+"\""+s[2][j]+"\","+
						      "\"content\":"+"\""+s[3][j]+"\"}";
					
					 if(j<9) 
				Json +=",";
					}
					System.out.println(Json);
			  Json += "]}";
			  if(h<code.length -1) 
			  Json +=",";
		}   Json += "]}";
		//생성파일 json으로 저장 
		FileWriter fileWriter = new FileWriter("C:\\edudata/"+FileName+".json");
		fileWriter.write(Json);
		fileWriter.close();
			 System.out.println("JSON 실행완료"); 
			 FileSystem hdfs = FileSystem.get(conf); 
			 //로컬저장 파일 하둡으로 전송
			 Path filePath = new Path("/edudata/naver_eco"); 
			 Path localPath = new Path("C:\\edudata/"+FileName+".json");
			 hdfs.copyFromLocalFile(localPath, filePath); 
			 if (hdfs != null) 
				 hdfs.close();
			}catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
		}finally {
		r.close(); 
		}
		System.out.println("수행 성공");
	}
	public static void main(String[] args) throws RserveException, IOException  {
		NewsCreate.createNews();
	}
}