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
public class HistoryController {

	@ModelAttribute("user")
	public UserVO createUserModel() {
		return null;
	}

	@Autowired
	HistoryDAO historyDAO;
	@Autowired
	AccountDAO accountDAO;
	@Autowired
	CompanyDAO companyDAO;
	
	@RequestMapping(value="/history", method = RequestMethod.GET)
	public ModelAndView getHistory(@ModelAttribute("user") UserVO userVO, @RequestParam(defaultValue="1") int page) {
		ModelAndView mav = new ModelAndView();
		
		//session이 없으면 login으로 보냄
		if(userVO == null) {
			mav.setViewName("redirect:/login");
			return mav;
		} else {
			
			//Account 생성 전이면 property로 보냄
			AccountVO accountVO = accountDAO.getAccount(userVO.getU_id());
			if(accountVO == null) {
				mav.setViewName("redirect:/property");
			} else {
				
				//페이징 작업
				int account_id = accountDAO.getAccount(userVO.getU_id()).getAccount_id();
				int historyCnt = historyDAO.getHistoryCnt(account_id);
				Pagination pagination = new Pagination(historyCnt, page);
				int startIndex = pagination.getStartIndex();
				
				List<HistoryVO> historyList = historyDAO.getHistoryList(account_id, startIndex);
				mav.addObject("historyList", historyList);
				mav.addObject("pagination", pagination);
				
				mav.setViewName("manage/history");				
			}
			
		}

		return mav;
	}
	
	@RequestMapping(value="/history/name", method = RequestMethod.POST)
	@ResponseBody
	public Object postName(@RequestBody String company_id) {
		HashMap<String, String> map = new HashMap<String, String>();
		String companyName = companyDAO.getCompanyName(company_id);
		map.put("name", companyName);
		return map;
	}
}
