package service;

import java.io.*;
import java.text.*;
import java.util.*;

import org.json.simple.*;
import org.springframework.stereotype.*;

@Service
public class EmotionService {
	
	@SuppressWarnings("unchecked")
	public void setEmotionJSON(String[][] value, String path) throws IOException {
		Date date= new Date();
		SimpleDateFormat current = new SimpleDateFormat("yyyy년 MM월 dd일 hh시 mm분");
		
		for(int i=0; i<value.length; i++) {
			JSONObject jsonObject = new JSONObject();
			JSONArray arr = new JSONArray();
			JSONObject info = new JSONObject();
			info.put("code", value[i][0]);
			info.put("pos", value[i][1]);
			info.put("neg", value[i][2]);
			info.put("predictValue",value[i][3]);
			info.put("predictPercent",value[i][4]);
			info.put("time",current.format(date));
			arr.add(info);
			jsonObject.put("emotion", arr);
			saveEmotionJSON(jsonObject, value[i][0], path);
		}
		
	}
	
	public void saveEmotionJSON(JSONObject jsonObject, String company, String path) throws IOException {
		BufferedWriter bw = new BufferedWriter(new FileWriter(path+"/emotion"+company+".json"));
		System.out.println("감정분석 저장");
		bw.write(jsonObject.toJSONString()); 
		bw.flush(); 
		bw.close();
	}
}
