package service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import dao.*;
import vo.*;

@Service
public class MyStockService {
	
	@Autowired
	PurchaseDAO purchaseDAO;
	@Autowired
	StockInfoService stockService;
	
	//보유한 주식 정보에 대한 List get
	public List<MyStockVO> getMyStockList(UserVO userVO, AccountVO accountVO) {
		List<MyStockVO> myStockList = purchaseDAO.getMyStock(accountVO.getAccount_id());
		
		for(int i=0; i<myStockList.size(); i++) {
			String code = myStockList.get(i).getCompany_id();
			StockInfoVO stockVO = stockService.getInfo(code);

			//각 종목에 대한 전일대비 set
			String sign = stockVO.getStockinfo()[2];
			if(sign.equals("1") || sign.equals("2") || sign.equals("3")) {
				sign = "▲";
			} else {
				sign = "▼-";
			}
			myStockList.get(i).setDebi(sign + stockVO.getStockinfo()[3]);
			
			//각 종목에 대한 동락 set
			myStockList.get(i).setDongrak(stockVO.getDungRakrate_str());
			
			//각 종목에 대한 손익, 수익률 set
			double curjuka = myStockList.get(i).getCurjuka();
			double price = myStockList.get(i).getPrice();
			int quantity = myStockList.get(i).getQuantity();
			int perPrice = (int)price/quantity;
			myStockList.get(i).setPrice(perPrice);
			
			double profit = (curjuka-perPrice) * quantity;
			double profit_rate = (curjuka - perPrice) / perPrice * 100;
			myStockList.get(i).setProfit((int)profit);
			myStockList.get(i).setProfit_rate(profit_rate);
			
			
			System.out.println("가격 " + price);
			System.out.println("수익 " + profit);
			System.out.println("수익률 : " + profit_rate);
			//System.out.println("주가 " + curjuka);
			
		}

		return myStockList;	
	}
	
}
