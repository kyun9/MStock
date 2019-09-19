package com.project.mstock;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;

@Controller
public class PropertyInfoController {
	@RequestMapping(value="/property", method = RequestMethod.GET)
	public ModelAndView propertyInfo() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("propertyInfo");
		return mav;
	}
}
