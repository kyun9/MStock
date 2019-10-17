package com.project.mstock;

import java.util.*;

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
	
	@RequestMapping(value="/bankruptcy", method = RequestMethod.POST)
	@ResponseBody
	public Object postBankruptcy(@RequestBody String u_id) {
		HashMap<String, String> map = new HashMap<String, String>();
		AccountVO accountVO = accountDAO.getAccount(Integer.parseInt(u_id));
		if(accountVO != null) {
			int credit = accountVO.getCredit();
			int curPrice = accountDAO.getAccountPrice(accountVO.getAccount_id());
			int totalPrice = credit+curPrice;
			map.put("result", "success");
			map.put("price", "" + totalPrice);
		} else {
			map.put("result", "fail");
		}
		return map;
	}
	
	@RequestMapping(value="/bankruptcy/process", method = RequestMethod.POST)
	@ResponseBody
	public Object postBankruptcyProcess(@RequestBody String u_id) {
		HashMap<String, String> map = new HashMap<String, String>();
		AccountVO accountVO = accountDAO.getAccount(Integer.parseInt(u_id));
		if(accountVO != null) {
			if(accountDAO.deleteAccount(accountVO.getAccount_id())) {
				if(accountDAO.insertAccount(accountVO)) {
					map.put("result", "success");
				} else {
					map.put("result", "fail");
				}
			} else {
				map.put("result", "fail");
			}
		} else {
			map.put("result", "fail");
		}
		return map;
	}
}
