package com.project.mstock;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;

import dao.*;
import vo.*;

@Controller
@SessionAttributes("user")
public class MyPageController {
	
	@Autowired
	RegisterDAO registerDAO;
	
	@ModelAttribute("user")
	public UserVO createUserModel() {
		return null;
	}
	
	@RequestMapping(value="/mypage", method = RequestMethod.GET)
	public ModelAndView getMyPage(@ModelAttribute("user") UserVO userVO) {
		ModelAndView mav = new ModelAndView();
		
		//session이 없으면 login으로 보냄
		if(userVO == null) {
			mav.setViewName("login");
		} else {
			mav.setViewName("mypage");			
		}
		
		return mav;
	}
	
	@RequestMapping(value="/mypage", method = RequestMethod.POST)
	public String postUpdateInfo(@ModelAttribute("user") UserVO userVO, String password) {
		
		if(registerDAO.updatePassword(userVO.getId(), password)) {
			System.out.println("success update password");
		} else {
			System.out.println("fail update password");
		};
		
		return "redirect:/logout";
	}
}
