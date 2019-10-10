package edu.spring.redu;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import rtest.NewsService;

@Controller
public class NewsController {
	@Autowired
	NewsService news;	
	
	@RequestMapping("/newsData")
	public ModelAndView sendInfo(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		String code = req.getParameter("code");
		if(code == null)
			code = "005390";
		mav.addObject("news_info", news.returnNews1(code));
		mav.setViewName("newsView");
		return mav;
	}	
}






