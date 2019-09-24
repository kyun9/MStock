package com.project.mstock;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;

import dao.*;
import vo.*;

@Controller
@SessionAttributes("user")
public class AccountController {

	@Autowired
	AccountDAO accountDAO;
	
	@ModelAttribute("user")
	public UserVO createUserModel() {
		return null;
	}
	
	@RequestMapping(value="/account/insert", method = RequestMethod.GET)
	public ModelAndView getAccountInsert(@ModelAttribute("user") UserVO user) {
		ModelAndView mav = new ModelAndView();
		AccountVO vo = new AccountVO();
		vo.setU_id(user.getU_id());
		if(accountDAO.insertAccount(vo)) {
			mav.addObject("account", "success");
		} else {
			mav.addObject("account", "fail");
		}
		
		mav.setViewName("propertyInfo");
		
		return mav;
	}
	
}
