package com.project.mstock;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;
import org.springframework.web.servlet.view.*;

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
	CompanyDAO companyDAO;
	@Autowired
	HistoryDAO historyDAO;
	
	@Autowired
	PropertyService propertyService;
	@Autowired
	MyStockService myStockService;
	@Autowired
	HistoryService historyService;
	
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
	
	//매도 처리
	@RequestMapping(value="/property/sell", method = RequestMethod.POST)
	public String getPropertyInfo(PurchaseVO purchaseVO) {
		
		//Credit Update 
		int curJuka = companyDAO.getCurJuka(purchaseVO.getCompany_id());
		int credit = curJuka * purchaseVO.getQuantity();
		
		if(accountDAO.updateCredit(purchaseVO.getAccount_id(), credit)) {
			//보유한 주식 개수와 매도하려는 주식 개수가 같으면 Delete 아니면 Update
			int quantity = purchaseDAO.getQuantity(purchaseVO.getList_id());
			boolean check = false;
			if(purchaseVO.getQuantity() == quantity) {
				if(purchaseDAO.sellStockDelete(purchaseVO)) {
					check = true;
					System.out.println("Delete Success");
				} else {
					System.out.println("Delete Fail");
				}
			} else {
				if(purchaseDAO.sellStockUpdate(purchaseVO)) {
					check = true;
					System.out.println("Update Success");
				} else {
					System.out.println("Update Fail");
				}
			}
			
			if(check) {
				HistoryVO historyVO = historyService.getHistory(purchaseVO, curJuka, "매도");
				historyDAO.insertHistory(historyVO);
			}
		}
		
		return "redirect:/property";
	}
	
	
	//Ajax 처리
	//보유하고 있는 종목 중 company_id의 구매목록 리스트를 보냄 
	@RequestMapping(value="/property/modal", method = RequestMethod.POST)
	@ResponseBody
	public Object postCheckEmail(@RequestParam(value="company_id") String company_id, @RequestParam(value="account_id") String account_id) {
		HashMap<String, List<PurchaseVO>> map = new HashMap<String, List<PurchaseVO>>();
		List<PurchaseVO> purchaseList = purchaseDAO.getOneCompanyStock(company_id, account_id);
		map.put("purchaseList", purchaseList);
		return map;
	}
	
}
