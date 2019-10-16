package com.project.mstock;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;

import dao.*;
import vo.*;

@Controller
@SessionAttributes("user")
public class BankruptcyController {
	
	@Autowired
	AccountDAO accountDAO;
	
	@ModelAttribute("user")
	public UserVO createUserModel() {
		return null;
	}
	
	@RequestMapping(value="/bankrupty", method = RequestMethod.GET)
	public ModelAndView getBankruptyWrite(@ModelAttribute("user") UserVO userVO) {
		ModelAndView mav = new ModelAndView();
		
		//session이 없으면 login으로 보냄
		if(userVO.getU_id() == 0) {
			mav.setViewName("auth/login");
		} else {
			mav.setViewName("manage/propertyInfo");
			
			//계좌를 보유 중인지 확인함
			AccountVO accountVO = accountDAO.getAccount(userVO.getU_id());
			if(accountVO == null) {
				mav.addObject("account", "fail");
			} else {
				//계좌를 보유
				mav.setViewName("bankruptcy");
			}
			
		}
		
		return mav;

	}
}
