package com.project.mstock;

import javax.servlet.http.*;

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
	@Autowired
	HttpSession session;
	
	@ModelAttribute("user")
	public UserVO createUserModel() {
		return new UserVO();
	}

	@RequestMapping(value = "/stockinfo", method = RequestMethod.GET)
	public ModelAndView stockinfoGet(@ModelAttribute("user") UserVO userVO, String code) {
		ModelAndView mav = new ModelAndView();
		
		//세션 없으면 로그인 페이지로 이동
		if(userVO.getU_id() == 0) {
			mav.setViewName("redirect:/login");
		} else {
			
			//계좌가 없으면 자산 관리 페이지로 이동(계좌 발급을 위해서)
			AccountVO accountVO = accountDAO.getAccount(userVO.getU_id());
			if(accountVO == null) {
				mav.setViewName("redirect:/property");
			} else {
				mav.addObject("info", service.getInfo(code));
				mav.addObject("comInfo", companyDAO.selectOneCompay(code));
				mav.addObject("accountInfo", accountVO);
				
				mav.setViewName("stockinfo/stockInfo");
			}
		session.setAttribute("codeValue", code);
		mav.addObject("info", service.getInfo(code));
		mav.addObject("comInfo", companyDAO.selectOneCompay(code));
		System.out.println("여기까지");
		if (userVO.getU_id() != 0) {
			mav.addObject("accountInfo", accountDAO.getAccount(userVO.getU_id()));
		}
		
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
