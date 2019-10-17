package com.project.mstock;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;
import org.springframework.web.servlet.mvc.support.*;

import dao.*;
import vo.*;

@Controller
@SessionAttributes("user")
public class PartialController {
	@Autowired
	AccountDAO accountDAO;
	@Autowired
	CompanyDAO companyDAO;
	
	@ModelAttribute("user")
	public UserVO createUserModel() {
		return null;
	}
	
	@RequestMapping(value="/search", method = RequestMethod.POST)
	public ModelAndView getSearch(@ModelAttribute("user") UserVO userVO, String word, RedirectAttributes redirectAttributes) {
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
				//단어를 검색
				List<String> code = companyDAO.getCompanyId(word);

				if(code.size() > 0) {
					mav.setViewName("redirect:/stockinfo?code=" + code.get(0));
				} else {
					redirectAttributes.addFlashAttribute("search", "검색 결과가 없습니다");
					mav.setViewName("redirect:/");
				}
			}
		}
		
		return mav;
	}
	
//	@RequestMapping(value="/partial/account", method = RequestMethod.POST)
//	@ResponseBody
//	public Object postAccount(@RequestBody String u_id) {
//		HashMap<String, String> map = new HashMap<String, String>();
//		AccountVO accountVO = accountDAO.getAccount(Integer.parseInt(u_id));
//		if(accountVO != null) {
//			map.put("result", "success");
//		} else {
//			map.put("result", "fail");
//		}
//		
//		return map;
//	}
	
	@RequestMapping(value="/partial/price", method = RequestMethod.POST)
	@ResponseBody
	public Object postPrice(@RequestBody String u_id) {
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
}
