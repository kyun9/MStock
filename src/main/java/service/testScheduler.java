package service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.lang.reflect.Type;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.rosuda.REngine.RList;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;
import org.springframework.scheduling.annotation.*;
import org.springframework.stereotype.*;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.project.mstock.*;

@Service
public class testScheduler {

	static HashMap<String, Integer> map = new HashMap<>();
	@Scheduled(fixedRate=60000)
	public static void createNews() {
		RConnection r = null;
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd"); // 파일명을 현재 연도-월-일-시-분으로 설정
		Gson gson = null;
		Type voListType = null;
		List<NewsRecode> newsRecode = null;
		List<NewCapsule> newCapsule = null;
		String[] code = { "006400", "000660", "012330", "035420", "066570", "068270", "090430", "004170", "055550",
				"035720", "010950", "161890" };
		String FileName = format1.format(System.currentTimeMillis());
		File filePath = new File("C:\\edudata/" + FileName + ".json");
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

			gson = new GsonBuilder().setPrettyPrinting().create();
			if (!filePath.exists()) {
				newCapsule = new ArrayList<NewCapsule>();
				newsRecode = new ArrayList<NewsRecode>();
			} else {
				voListType = new TypeToken<List<NewCapsule>>() {}.getType();
				BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(filePath), "UTF8"));
				newCapsule = gson.fromJson(reader, voListType);
				reader.close();
			}

			for (int h = 0; h < code.length; h++) { // 회사 개수 12개
				newsRecode = new ArrayList<NewsRecode>();
				r.eval("code = '" + code[h] + "'");
				r.eval("url <- paste(\"https://finance.naver.com/item/news_news.nhn?code=\",code, sep=\"\")");
				r.eval("remDr$navigate(url)");
				r.eval("navereconomic_contents<-NULL");
				r.eval("navereco_info<-NULL");
				r.eval("source('c:/Rstudy/new_for.R')");
				RList list = r.eval("navereco_info").asList();

				// 파일을 바꿀 필요가 없음 바로 출력할 필요가 없음
				String[][] articleItem = new String[4][10];
				for (int i = 0; i < 4; i++) { // 항목 개수 4개
					articleItem[i] = list.at(i).asStrings();
				}
				for (int j = 0; j < 10; j++) {
					if(!map.containsKey(articleItem[0][j])) {
						map.put(articleItem[0][j], 1);
						newsRecode.add(
								new NewsRecode(articleItem[0][j], articleItem[1][j], articleItem[2][j], articleItem[3][j]));
						System.out.println("새로운 기사 추가");
					}
					else {
						System.out.println("이미 있음");
					}
					System.out.println("완료 " + j);
				}
				newCapsule.add(new NewCapsule(code[h], newsRecode));
			}
			Writer writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(filePath), "utf-8"));
			gson.toJson(newCapsule, writer);
			writer.close();
			System.out.println(map.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}