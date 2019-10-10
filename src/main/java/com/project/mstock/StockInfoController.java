package com.project.mstock;

import java.util.*;

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
	@Autowired
	PurchaseDAO purchasesDAO;

	@ModelAttribute("user")
	public UserVO createUserModel() {
		return new UserVO();
	}

	@RequestMapping(value = "/stockinfo", method = RequestMethod.GET)
	public ModelAndView stockinfoGet(@ModelAttribute("user") UserVO userVO, String code) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("info", service.getInfo(code));
		mav.addObject("comInfo", companyDAO.selectOneCompay(code));
		if (userVO.getU_id() != 0) {
			mav.addObject("accountInfo", accountDAO.getAccount(userVO.getU_id()));
		}
		mav.setViewName("stockInfo");
		return mav;
	}

	@RequestMapping(value = "/stockinfo", method = RequestMethod.POST)
	public ModelAndView stockinfoPost(@ModelAttribute("user") UserVO userVO, PurchaseVO purchaseVO) {
		ModelAndView mav = new ModelAndView();
		purchasesDAO.purchaseStock(purchaseVO);
		mav.setViewName("redirect:/stockinfo?code=" + purchaseVO.getCompany_id());
		return mav;
	}


}
