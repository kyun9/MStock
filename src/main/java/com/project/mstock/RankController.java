package com.project.mstock;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

import dao.*;
import service.*;
import vo.*;

@Controller
public class RankController {
	
	@Autowired
	RankDAO rankDAO;
	@Autowired
	AccountDAO accountDAO;
	
	//수동으로 랭크 돌리기
	@Autowired
	RankScheduler rankService;
	
	@RequestMapping(value="/rank", method = RequestMethod.GET)
	public String getTemp(Model model, @RequestParam(defaultValue="1") int page){
		
		//수동으로 랭크 돌리기
		//rankService.updateRank();
		
		//Paging
		int accountCnt = accountDAO.getAccountCnt();
		Pagination pagination = new Pagination(accountCnt, page);
		int startIndex = pagination.getStartIndex();
		
		List<RankVO> list = rankDAO.getRankList(startIndex);
		model.addAttribute("rankList", list);
		model.addAttribute("pagination", pagination);
		
		return "rank";
	}
}