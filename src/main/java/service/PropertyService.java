package service;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import dao.*;
import vo.*;

@Service
public class PropertyService {

	@Autowired
	PurchaseDAO purchaseDAO;
	
	//현재 자산정보 set
	public PropertyVO setProperty(UserVO userVO, AccountVO accountVO) {
		PropertyVO propertyVO = new PropertyVO();
		
		//credit set
		int credit = accountVO.getCredit();
		propertyVO.setCredit(credit);
		
		//stock_value set(전체 주식 가치를 합한 값)
		int stock_value = purchaseDAO.getStockValue(accountVO.getAccount_id());
		propertyVO.setStock_value(stock_value);
		
		//profit_late set(수익률)
		double total_value = credit+stock_value;
		double profit_rate = (total_value - 10000000) / 10000000 * 100;
		propertyVO.setProfit_rate(profit_rate);
		
		return propertyVO;
	}
}
