package service;

import java.util.*;

import javax.servlet.*;

import org.rosuda.REngine.*;
import org.rosuda.REngine.Rserve.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

@Service
public class RegressionService {
	@Value("#{config['rsource.regressionAnalysis']}")
	String rsource_location;
	@Autowired
	ServletContext context;

	public HashMap<String,Double> getStockRegression(String code){
		System.out.println("함수 들어옴");
		HashMap<String, Double> map = new HashMap<String,Double>();
		String path = context.getRealPath("/").replaceAll("\\\\", "/") + "resources/json/";
		System.out.println("hi");
		RConnection r = null;
		System.out.println("hi2");
		try {
			r = new RConnection();
			System.out.println("r연결");
			r.eval("code = '" + code + "'");
			System.out.println("함수 안");
			r.eval("path = '" + path + "'");
			System.out.println("함수 안");
			r.eval("source(" + rsource_location + ")");
			
			System.out.println("함수 안2");
			RList list;
			try {
				list = r.eval("result").asList();
				System.out.println("list 읽음");
				map.put("predictValue", list.at(0).asDouble());
				map.put("predictPercent", list.at(1).asDouble());
			} catch (REXPMismatchException e) {
				e.printStackTrace();
			}
		} catch (RserveException e) {
			e.printStackTrace();
		}finally {
			r.close();
		}

		System.out.println(map.get("predictValue"));
		System.out.println(map.get("predictPercent"));
		return map;
	}
}
