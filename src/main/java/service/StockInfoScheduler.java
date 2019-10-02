package service;

import java.io.*;
import java.lang.reflect.*;
import java.util.*;

import javax.servlet.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.scheduling.annotation.*;
import org.springframework.stereotype.*;

import com.google.gson.*;
import com.google.gson.reflect.*;

import dao.*;
import vo.*;

@Service
public class StockInfoScheduler {
	@Autowired
	StockInfoService service;
	@Autowired
	StockInfoDAO stockinfoDAO;
	@Autowired
	CompanyDAO companyDAO;
	@Autowired
	ServletContext context;
	
	static String[] stockInfos = { "006400", "000660", "012330", "035420", "066570", "068270", "090430", "004170",
			"055550", "035720", "010950", "161890" };

//	task 꺼둠
//	@Scheduled(cron="0/10 0 9-16 ? * MON-FRI")  // 월요일~금, 9시에서 16시,10초간격
//	@Scheduled(cron = "0/10 * * * * *") // 10초간격
//	public void scheduleRun() {
//		StockInfoVO vo = new StockInfoVO();
//		try {
//			for (int i = 0; i < stockInfos.length; i++) {
//				vo = service.getInfo(stockInfos[i]);
//				String curJuka = vo.getStockinfo()[1].replace(",", "");
//				if (stockinfoDAO.insertStockInfo(vo.getJongCd(), curJuka, vo.getGettime())) {
//					System.out.println("insert 완료");
//					System.out.println(vo.getGettime());
//				}
//				if (companyDAO.updateCurjuka(curJuka, vo.getJongCd())) {
//					System.out.println("company curjuka update 완료");
//				}
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}

	// 종목 code별 json파일 생성
	// @Scheduled(cron="0/10 0 9-16 ? * MON-FRI") // 월요일~금, 9시에서 16시,10초간격
//	@Scheduled(cron = "0/10 * * * * *") // 10초간격 test
//	public void scaheduleJSON() {
//		StockInfoVO vo = new StockInfoVO();
//		try {
//			for (int i = 0; i < stockInfos.length; i++) {
//				//json형태로 변환해줄 gson 객체 생성
//				Gson gson = new GsonBuilder().setPrettyPrinting().create();
//				
//				//원하는 종목을  service에서 파싱해와서 vo객체 담고 fileName을 종목코드명을 지정
//				vo = service.getInfo(stockInfos[i]);
//				String filePath = "c:/uploadtest/" + vo.getJongCd() + ".json";
//				
//				//파일에 utf-8로 인코딩하고 json파일에 append  
//				BufferedWriter writer = new BufferedWriter(
//						new OutputStreamWriter(new FileOutputStream(filePath, true), "UTF-8"));
//				gson.toJson(vo, writer);
//				writer.close();
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}

	@Scheduled(cron = "0/10 * * * * *") // 10초간격 test
	public void scaheduleJSON() {
		StockInfoVO vo = new StockInfoVO();
		Gson gson=null;
		Type voListType =null;
		try {
			for (int i = 0; i < stockInfos.length; i++) {
				if(companyDAO.updateCurjuka(vo.getStockinfo()[1], vo.getJongCd())) {
					System.out.println("companys 테이블 현재 주가 update");
				}
				vo = service.getInfo(stockInfos[i]);
				gson = new GsonBuilder().setPrettyPrinting().create();
				// json array 파싱할때 클래스 리터럴을 stockInfoVO로 준다,표시된 형식을 반환(getType())
				voListType = new TypeToken<List<StockInfoVO>>(){}.getType();
				String filePath = context.getRealPath("/")+"/resources/json/" + vo.getJongCd() + ".json";
				System.out.println(filePath);
				File f = new File(filePath);
				List<StockInfoVO> vos =null;
				if(f.exists()) {   //파일 존재 시
					BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(filePath),"UTF8"));
					//JSON 형식의 데이터를 지정한 타입의 데이터로 변환한걸 list에 저장
					vos = gson.fromJson(reader, voListType);
					reader.close();
					System.out.println("파일있음");
				}
				else{   //파일 없을 시
					vos = new ArrayList<StockInfoVO>();
					System.out.println("파일없음");
				}
				//list에 새로운 객체 추가
				vos.add(vo);
				Writer writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(filePath), "utf-8"));
				//지정된 타입의 데이터를 JSON 형식의 데이터로 변환 , 두번째인자를 filewriter로 주어 file 추가 
				gson.toJson(vos, writer);
				writer.close();
				System.out.println("파일 write 성공 "+stockInfos[i]+vo.getGettime() );
			}
			System.out.println("============================");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

//	@Scheduled(cron="* 30 8 * * MON-FRI")   //월~금 8시 30분 stockinfos 테이블 초기화
//	@Scheduled(cron="0/30 * * * * *")     //30초간격
//	public void clearStockDB() {
//		if(dao.clearStockDB()) {
//			System.out.println("=======================");
//			System.out.println("clear stockinfoDB");
//			System.out.println("=======================");
//		}
//	}

//	json 파일 삭제 
//	@Scheduled(cron="* 30 8 * * MON-FRI")   //월~금 8시 30분 종목별 json파일삭제 
//	@Scheduled(cron="0/10 * * * * *")     //30초간격 test
//	public void clearStockDB() {
//		try {
//			for (int i = 0; i < stockInfos.length; i++) {
//				File file = new File(context.getRealPath("/")+"/resources/json/"+stockInfos[i]+".json");
//				if( file.exists() ){
//					if(file.delete()){
//		    			System.out.println("파일삭제 성공");
//		    		}else{
//		    			System.out.println("파일삭제 실패");
//		    		}
//				}
//			}
//		}catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
}
