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
	CompanyDAO dao;
	@Autowired
	StockInfoService service;
	@ModelAttribute("user")
	public UserVO createUserModel() {
		return new UserVO();
	}
	
	@RequestMapping(value = "/stockinfo", method = RequestMethod.GET)
	public ModelAndView stockinfo(@ModelAttribute("user") UserVO vo,String code) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("info", service.getInfo(code));
		mav.addObject("comInfo",dao.selectOneCompay(code));
		mav.setViewName("stockInfo");
		return mav;
	}
	
}
