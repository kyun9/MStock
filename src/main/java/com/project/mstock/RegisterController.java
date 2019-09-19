package com.project.mstock;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;

import dao.*;
import vo.*;

@Controller
public class RegisterController {
	
	@Autowired
	RegisterDAO dao;
	
	@RequestMapping(value="/register", method = RequestMethod.GET)
	public String getRegister() {
		return "register";
	}
	
	@RequestMapping(value="/register", method = RequestMethod.POST)
	public ModelAndView postRegister(UserVO vo) {
		ModelAndView mav = new ModelAndView();
		
		if(!dao.checkId(vo.getId())) {
			mav.addObject("msg", "중복된 아이디입니다");
		} else if(!dao.checkNickname(vo.getNickname())) {
			mav.addObject("msg", "중복된 닉네임입니다");
		} else if(!dao.checkEmail(vo.getEmail())) {
			mav.addObject("msg", "중복된 이메일입니다");
		} else {
			if(dao.insert(vo)) {
				mav.addObject("msg", "회원가입에 성공하였습니다");
				mav.addObject("result", "success");
			} else {
				mav.addObject("msg", "회원가입에 성공하였습니다");
				mav.addObject("result", "fail");
			}
		}
		
		mav.setViewName("register");
		
		return mav;
	}
		
	
}
