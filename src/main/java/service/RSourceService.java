package service;

import java.io.*;

import org.rosuda.REngine.*;
import org.rosuda.REngine.Rserve.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

@Service
public class RSourceService {
	@Value("#{config['rsource.path']}")
	  String rsource_path;
	
	@Value("#{config['rsource.location']}")
	  String rsource_location;
	
	@Autowired
	EmotionService emotionService;
	
	public void rdata() throws RserveException, REXPMismatchException, IOException{  
		
		//RConnection & 감정분석결과 get
		RConnection rc = new RConnection();
		rc.eval("setwd("+rsource_path+")");
		REXP wd = rc.eval("getwd()");
		System.out.println(wd.asString());
		REXP x = rc.eval("rdata<-source("+rsource_location+"); rdata$value");
		 rc.close();
		 
		RList list = x.asList();
		int rows = list.size();
		int cols = list.at(0).length();
		
		String[][] value = new String[rows][];
		for(int i=0; i<rows; i++) {
			value[i] = list.at(i).asStrings();
		}
		
		//JSON화
		emotionService.setEmotionJSON(value);
		
		/* 감정분석결과 출력
		 * for(int i=0; i<rows; i++) { for(int j=0; j<cols; j++) {
		 * System.out.println(value[i][j] + " "); } System.out.println(); }
		 */
	    
	}
	
	public void temp() throws IOException {
		BufferedWriter bw = new BufferedWriter(new FileWriter("C:/YG/eclipse-workspace/MStock/src/main/webapp/resources/rdata/json/temp.json"));
		bw.write("hi");
		bw.close();
	}
}
