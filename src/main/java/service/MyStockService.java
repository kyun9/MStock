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
	
	//보유한 주식 정보에 대한 List get
	public List<MyStockVO> getMyStockList(UserVO userVO, AccountVO accountVO) {
		List<MyStockVO> myStockList = purchaseDAO.getMyStock(accountVO.getAccount_id());
		
		for(int i=0; i<myStockList.size(); i++) {
			//각 종목에 대한 동락 set
			myStockList.get(i).setDongrak("12.0%");
			
			//각 종목에 대한 전일대비 set
			myStockList.get(i).setDebi("▲1200");
			
			//각 종목에 대한 손익, 수익률 set
			double curjuka = myStockList.get(i).getCurjuka();
			double price = myStockList.get(i).getPrice();
			int quantity = myStockList.get(i).getQuantity();
			double profit = (curjuka-price) * quantity;
			double profit_rate = (curjuka - price) / price * 100;
			myStockList.get(i).setProfit((int)profit);
			myStockList.get(i).setProfit_rate(profit_rate);
		}

		return myStockList;	
	}
	
}
