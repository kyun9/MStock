package com.project.mstock;

import java.util.*;

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
	PurchaseDAO purchaseDAO;
	@Autowired
	PropertyService propertyService;
	@Autowired
	MyStockService myStockService;
	
	@ModelAttribute("user")
	public UserVO createUserModel() {
		return null;
	}
	
	@RequestMapping(value="/property", method = RequestMethod.GET)
	public ModelAndView getPropertyInfo(@ModelAttribute("user") UserVO userVO) {

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
				
				//유저의 현재 자산 정보(credit, stock, profit)를 저장할 객체 생성
				PropertyVO propertyVO = propertyService.getProperty(userVO, accountVO);
				mav.addObject("propertyVO", propertyVO);
				
				//유저의 보유 주식을 저장할 객체 생성
				List<MyStockVO> myStockList = myStockService.getMyStockList(userVO, accountVO);
				mav.addObject("myStockList", myStockList);
			}
			
		}
		
		
		return mav;
	}
	
	@RequestMapping(value="/property/modal", method = RequestMethod.POST)
	@ResponseBody
	public Object postCheckEmail(@RequestParam(value="company_id") String company_id, @RequestParam(value="account_id") String account_id) {
		HashMap<String, List<PurchaseVO>> map = new HashMap<String, List<PurchaseVO>>();
		List<PurchaseVO> purchaseList = purchaseDAO.getOneCompanyStock(company_id, account_id);
		map.put("purchaseList", purchaseList);
		return map;
	}
	
}
