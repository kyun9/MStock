package com.project.mstock;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class StockInfoController {
	@RequestMapping(value = "/stockinfo", method = RequestMethod.GET)
	public ModelAndView home(String code) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("stockInfo");
		return mav;
	}
	
}
