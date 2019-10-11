package com.project.mstock;

import java.io.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;
import org.springframework.web.servlet.*;

import dao.*;
import service.*;
import vo.*;

@Controller
@SessionAttributes("user")
public class MyPageController {
	
	@Autowired
	RegisterDAO registerDAO;
	@Autowired
	PasswordService passwordService;
	@Autowired
	ImageService imageService;
	
	@ModelAttribute("user")
	public UserVO createUserModel() {
		return null;
	}
	
	@RequestMapping(value="/mypage", method = RequestMethod.GET)
	public ModelAndView getMyPage(@ModelAttribute("user") UserVO userVO) {
		ModelAndView mav = new ModelAndView();
		
		//session이 없으면 login으로 보냄
		if(userVO == null) {
			mav.setViewName("redirect:/login");
		} else {
			mav.setViewName("manage/mypage");			
		}
		
		//System.out.println(userVO.getId());
		return mav;
	}
	
	@RequestMapping(value="/mypage", method = RequestMethod.POST)
	public String postUpdateInfo(@ModelAttribute("user") UserVO userVO, @RequestParam(value="profileImg", required=false) MultipartFile file, String status, String password) throws IllegalStateException, IOException {
		
		//file이 null이 아닐경우
		if(!file.isEmpty()) {
			String imagePath = imageService.getPath(file, userVO.getId());
			if(registerDAO.updateImg(userVO.getId(), imagePath)) {
				System.out.println("success update image");
			} else {
				System.out.println("fail update image");
			}
		}
		
		//local일 경우에만 비밀번호 변경
		if(status.equals("local")) {
			if(registerDAO.updatePassword(userVO.getId(), passwordService.getEncodedPassword(password))) {
				System.out.println("success update password");
			} else {
				System.out.println("fail update password");
			}
		}
		
		return "redirect:/logout";
	}
}
