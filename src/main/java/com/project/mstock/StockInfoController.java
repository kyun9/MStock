package com.project.mstock;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;

import dao.*;
import service.*;
import vo.*;

@Controller
@SessionAttributes("user")
public class StockInfoController {
	@Autowired
	CompanyDAO companyDAO;
	@Autowired
	StockInfoService service;
	@Autowired
	AccountDAO accountDAO;
	
	@ModelAttribute("user")
	public UserVO createUserModel() {
		return new UserVO();
	}
	
	@RequestMapping(value = "/stockinfo", method = RequestMethod.GET)
	public ModelAndView stockinfo(@ModelAttribute("user") UserVO userVO,String code) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("info", service.getInfo(code));
		mav.addObject("comInfo",companyDAO.selectOneCompay(code));
		if(userVO.getU_id()!=0) {
			mav.addObject("accountInfo", accountDAO.getAccount(userVO.getU_id()));
		}
		mav.setViewName("stockInfo");
		return mav;
	}
	
}
