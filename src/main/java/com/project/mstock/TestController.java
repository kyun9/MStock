package com.project.mstock;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;

import dao.*;
import vo.*;

@Controller
@SessionAttributes("user")
public class TestController {
	
	@Autowired
	PurchaseDAO purchaseDAO;
	
	@Autowired
	AccountDAO accountDAO;
	
	@ModelAttribute("user")
	public UserVO createUserModel() {
		return null;
	}
	
	@RequestMapping(value="/test", method = RequestMethod.GET)
	public ModelAndView propertyInfo(@ModelAttribute("user") UserVO vo) {
		ModelAndView mav = new ModelAndView();
		if(vo != null){
			int account_id = accountDAO.getAccount(vo.getU_id()).getAccount_id();
			int value = purchaseDAO.getStockValue(account_id);
			System.out.println(value);

		}
				
		return mav;
	}
	
}
