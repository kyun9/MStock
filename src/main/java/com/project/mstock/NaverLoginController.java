package com.project.mstock;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

import dao.*;
import service.*;
import vo.*;

@Controller
@SessionAttributes("user")
public class NaverLoginController {
	
	@Autowired
	LoginDAO loginDAO;
	@Autowired
	RegisterDAO registerDAO;
	@Autowired
	NaverLoginService service;
	
	/*
	 * @Value("${naver.client_id}") private String client_id;
	 * @Value("${naver.client_secret}") private String client_secret;
	 */
	
	@ModelAttribute("user")
	public UserVO createUserModel() {
		return new UserVO();
	}
	
	@RequestMapping(value="/naver/login", method=RequestMethod.GET)
	public String postNaverLogin(Model model) {
		//model.addAttribute("client_id", client_id);
		return "auth/naverlogin";
	}
	
	@RequestMapping(value="/naver/callback", method = RequestMethod.GET)
	public String getCallback(String code, String state) {
		return "auth/callback";
	}
	
	@RequestMapping(value="/naver/profile", method = RequestMethod.GET)
	public String getProfile(String access_token, Model model) {
		UserVO vo = service.getProfile(access_token);
		if(vo != null) {
			if(!loginDAO.checkUser(vo.getId())) {
				registerDAO.insert(vo);
			}
			model.addAttribute("user", loginDAO.getUserInfo(vo.getId()));
		}
		
		return "redirect:http://localhost:8000/mstock";
	}
}
