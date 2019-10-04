package service;

import java.io.*;

import org.json.simple.*;
import org.springframework.stereotype.*;

@Service
public class EmotionService {
	
	@SuppressWarnings("unchecked")
	public void setEmotionJSON(String[][] value) throws IOException {
		
		JSONObject jsonObject = new JSONObject();
		JSONArray arr = new JSONArray();
		
		for(int i=0; i<value.length; i++) {
			JSONObject info = new JSONObject();
			info.put("code", value[i][0]);
			info.put("pos", value[i][1]);
			info.put("neg", value[i][2]);
			arr.add(info);
		}
		
		jsonObject.put("emotion", arr);
		
		for(int i=0; i<value.length; i++) {
			saveEmotionJSON(jsonObject, value[i][0]);
		}
		
	}
	
	public void saveEmotionJSON(JSONObject jsonObject, String code) throws IOException {
		BufferedWriter bw = new BufferedWriter(new FileWriter("C:/YG/eclipse-workspace/MStock/src/main/webapp/resources/rdata/json/emotion"+code+".json"));
		//FileWriter file = new FileWriter("/resources/rdata/json/emotion"+code+".json");
		bw.write(jsonObject.toJSONString()); 
		bw.flush(); 
		bw.close();
	}
}
