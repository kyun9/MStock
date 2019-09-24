package service;

import java.io.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import dao.CompanyDAO;
import dao.StockInfoDAO;
import vo.StockInfoVO;

@Service
public class StockInfoScheduler {
	@Autowired
	StockInfoService service;
	@Autowired
	StockInfoDAO stockinfoDAO;
	@Autowired
	CompanyDAO companyDAO;
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
	
	
	//종목 code별 json파일 생성
	//@Scheduled(cron="0/10 0 9-16 ? * MON-FRI")  // 월요일~금, 9시에서 16시,10초간격
	@Scheduled(cron = "0/10 * * * * *") // 10초간격 test
	public void scaheduleJSON() {
		StockInfoVO vo = new StockInfoVO();
		try {
			for (int i = 0; i < stockInfos.length; i++) {
				//json형태로 변환해줄 gson 객체 생성
				Gson gson = new GsonBuilder().setPrettyPrinting().create();
				
				//원하는 종목을  service에서 파싱해와서 vo객체 담고 fileName을 종목코드명을 지정
				vo = service.getInfo(stockInfos[i]);
				String filePath = "c:/uploadtest/" + vo.getJongCd() + ".json";
				
				//파일에 utf-8로 인코딩하고 json파일에 append  
				BufferedWriter writer = new BufferedWriter(
						new OutputStreamWriter(new FileOutputStream(filePath, true), "UTF-8"));
				gson.toJson(vo, writer);
				writer.close();
			}
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
	@Scheduled(cron="0/10 * * * * *")     //30초간격 test
	public void clearStockDB() {
		try {
			for (int i = 0; i < stockInfos.length; i++) {
				File file = new File("c:/uploadtest/"+stockInfos[i]+".json");
				if( file.exists() ){
					if(file.delete()){
		    			System.out.println("파일삭제 성공");
		    		}else{
		    			System.out.println("파일삭제 실패");
		    		}
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
}
