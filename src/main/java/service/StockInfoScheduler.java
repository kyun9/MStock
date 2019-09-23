package service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

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
	static String[] stockInfos= {"006400","000660","012330","035420","066570","068270",
			"090430","004170","033780","035720","010950","161890"};
	
//	task 꺼둠
//	@Scheduled(cron="0/10 0 9-16 ? * MON-FRI")  // 월요일~금, 9시에서 16시,10초간격
	@Scheduled(cron="0/10 * * * * *")  // 10초간격
	public void scheduleRun() {
		StockInfoVO vo= new StockInfoVO();
		try {
			for(int i=0;i<stockInfos.length;i++) {
				vo = service.getInfo(stockInfos[i]);
				String curJuka = vo.getStockinfo()[1].replace(",", "");
				if(stockinfoDAO.insertStockInfo(vo.getJongCd(), curJuka, vo.getGettime())) {
					System.out.println("insert 완료");
					System.out.println(vo.getGettime());
				}
				if(companyDAO.updateCurjuka(curJuka, vo.getJongCd())) {
					System.out.println("company curjuka update 완료");
				}
			}
		}catch(Exception e) {
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
}
