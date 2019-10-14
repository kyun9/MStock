package service;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import dao.*;
import vo.*;

@Service
public class PropertyService {

	@Autowired
	PurchaseDAO purchaseDAO;
	@Autowired
	RankDAO rankDAO;
	
	//현재 자산정보 get
	public PropertyVO getProperty(UserVO userVO, AccountVO accountVO) {
		PropertyVO propertyVO = new PropertyVO();
		
		//credit set
		int credit = accountVO.getCredit();
		propertyVO.setCredit(credit);
		
		//price_value set(전체 주식 구매 금액을 합한 값)
		int price_value = 0;
		if(purchaseDAO.checkStock(accountVO.getAccount_id()) != 0) {
			price_value = purchaseDAO.getPriceValue(accountVO.getAccount_id());
		}
		propertyVO.setPrice_value(price_value);
		
		//stock_value set(전체 주식 가치를 합한 값)
		int stock_value = 0;
		if(purchaseDAO.checkStock(accountVO.getAccount_id()) != 0) {
			stock_value = purchaseDAO.getStockValue(accountVO.getAccount_id());
		}
		propertyVO.setStock_value(stock_value);
		
		//profit_late set(수익률)
		double total_value = credit+stock_value;
		double profit_rate = (total_value - 10000000) / 10000000 * 100;
		propertyVO.setProfit_rate(profit_rate);
		//System.out.println("수익률 : " + profit_rate);
		
		//grade set(등급)
		String grade = rankDAO.getGrade(credit+stock_value);
		propertyVO.setGrade(grade);
		
		return propertyVO;
	}
}
