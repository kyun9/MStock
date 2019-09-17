package com.project.mstock;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("home");
		return mav;
	}
	@RequestMapping(value = "/default", method = RequestMethod.GET)
	public ModelAndView homes() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("default");
		return mav;
	}
	
}
