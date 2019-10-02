package com.project.mstock;

import java.util.*;

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
			vo.setStatus("local");
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
	
	@RequestMapping(value="/register/check/id", method = RequestMethod.POST)
	@ResponseBody
	public Object postCheckId(@RequestBody String id) {
		HashMap<String, String> map = new HashMap<String, String>();
		if(dao.checkId(id)) {
			map.put("msg", "사용 가능한 아이디입니다");
			map.put("result", "success");
		} else {
			map.put("msg", "중복된 아이디입니다");
			map.put("result", "fail");
		}
		return map;
	}
	
	@RequestMapping(value="/register/check/nickname", method = RequestMethod.POST)
	@ResponseBody
	public Object postCheckNickname(@RequestBody String nickname) {
		HashMap<String, String> map = new HashMap<String, String>();
		if(dao.checkNickname(nickname)) {
			map.put("msg", "사용 가능한 닉네임입니다");
			map.put("result", "success");
		} else {
			map.put("msg", "중복된 닉네임입니다");
			map.put("result", "fail");
		}
		return map;
	}
	
	@RequestMapping(value="/register/check/email", method = RequestMethod.POST)
	@ResponseBody
	public Object postCheckEmail(@RequestBody String email) {
		HashMap<String, String> map = new HashMap<String, String>();
		if(dao.checkEmail(email)) {
			map.put("msg", "사용 가능한 이메일입니다");
			map.put("result", "success");
		} else {
			map.put("msg", "중복된 이메일입니다");
			map.put("result", "fail");
		}
		return map;
	}
		
	
}
