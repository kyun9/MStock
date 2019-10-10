package com.project.mstock;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import dao.CompanyDAO;
import vo.UserVO;

@Controller
@SessionAttributes("user")
public class HomeController {
	@Autowired
	CompanyDAO companyDAO;
	@ModelAttribute("user")
	public UserVO createUserModel() {
		return new UserVO();
	}
	
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home() {
		ModelAndView mav = new ModelAndView();
		mav.addObject("companyInfo", companyDAO.listAll());
		mav.setViewName("home");
		return mav;
	}
	@RequestMapping(value = "/default", method = RequestMethod.GET)
	public ModelAndView homes() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("default");
		return mav;
	}
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public ModelAndView test(@ModelAttribute("user") UserVO userVO) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("test");
		return mav;
	}
}
