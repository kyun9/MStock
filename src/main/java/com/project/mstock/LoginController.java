package com.project.mstock;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;

import dao.*;
import vo.*;

@Controller
@SessionAttributes("user")
public class LoginController {
	
	@Autowired
	LoginDAO dao;
	
	@ModelAttribute("user")
	public UserVO createUserModel() {
		return new UserVO();
	}
	
	@RequestMapping(value="/login", method = RequestMethod.GET)
	public String getLogin() {
		return "login";
	}
	
	@RequestMapping(value="/login", method = RequestMethod.POST)
	public ModelAndView postLogin(@ModelAttribute("user") UserVO vo) {
		ModelAndView mav = new ModelAndView();
		
		if(dao.checkLogin(vo)) {
			mav.addObject("msg", "로그인에 성공하였습니다");
			mav.addObject("result", "success");
		} else {
			mav.addObject("msg", "아이디와 비밀번호를 확인해주세요");
			mav.addObject("result", "fail");
		}
		
		mav.setViewName("login");
		
		return mav;
	}
}
