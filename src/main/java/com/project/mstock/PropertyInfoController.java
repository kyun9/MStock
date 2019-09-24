package com.project.mstock;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;

import dao.*;
import service.*;
import vo.*;

@Controller
@SessionAttributes("user")
public class PropertyInfoController {
	
	@Autowired
	AccountDAO accountDAO;
	@Autowired
	PropertyService propertyService;
	
	@ModelAttribute("user")
	public UserVO createUserModel() {
		return null;
	}
	
	@RequestMapping(value="/property", method = RequestMethod.GET)
	public ModelAndView propertyInfo(@ModelAttribute("user") UserVO userVO) {

		ModelAndView mav = new ModelAndView();
		
		//session이 없으면 login으로 보냄
		if(userVO == null) {
			mav.setViewName("login");
		} else {
			mav.setViewName("propertyInfo");
			
			//계좌를 보유 중인지 확인함
			AccountVO accountVO = accountDAO.getAccount(userVO.getU_id());
			if(accountVO == null) {
				mav.addObject("account", "fail");
			} else {
				
				//계좌를 보유
				mav.addObject("account", "success");
				mav.addObject("accountVO", accountVO);
				
				//유저의 credit, stock, profit을 저장할 객체 생성
				PropertyVO propertyVO = propertyService.setProperty(userVO, accountVO);
				mav.addObject("propertyVO", propertyVO);
			}
			
		}
		
		
		return mav;
	}
}
