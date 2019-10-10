package service;

import java.io.*;

import org.json.simple.*;
import org.springframework.stereotype.*;

@Service
public class EmotionService {
	
	@SuppressWarnings("unchecked")
	public void setEmotionJSON(String[][] value, String path) throws IOException {
		
		for(int i=0; i<value.length; i++) {
			JSONObject jsonObject = new JSONObject();
			JSONArray arr = new JSONArray();
			JSONObject info = new JSONObject();
			info.put("code", value[i][0]);
			info.put("pos", value[i][1]);
			info.put("neg", value[i][2]);
			arr.add(info);
			jsonObject.put("emotion", arr);
			saveEmotionJSON(jsonObject, value[i][0], path);
		}
		
	}
	
	public void saveEmotionJSON(JSONObject jsonObject, String code, String path) throws IOException {
		BufferedWriter bw = new BufferedWriter(new FileWriter(path+"/emotion"+code+".json"));
		System.out.println("감정분석 저장");
		//FileWriter file = new FileWriter("/resources/rdata/json/emotion"+code+".json");
		bw.write(jsonObject.toJSONString()); 
		bw.flush(); 
		bw.close();
	}
}
