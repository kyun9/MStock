package com.project.mstock;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import service.StockInfoService;

@Controller
public class StockInfoController {
	@Autowired
	StockInfoService service;
	
	@RequestMapping(value = "/stockinfo", method = RequestMethod.GET)
	public ModelAndView home(String code) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("info", service.getInfo(code));
		mav.setViewName("stockInfo");
		return mav;
	}
	
}
