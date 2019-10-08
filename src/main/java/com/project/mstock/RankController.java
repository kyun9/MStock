package com.project.mstock;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

import dao.*;
import vo.*;

@Controller
public class RankController {
	
	@Autowired
	RankDAO rankDAO;
	
	@RequestMapping(value="/rank", method = RequestMethod.GET)
	public String getTemp(Model model){
		List<RankVO> list = rankDAO.getRankList();
		model.addAttribute("rankList", list);
		return "rank";
	}
}