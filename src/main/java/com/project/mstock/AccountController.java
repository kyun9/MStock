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
	public String getAccountInsert(@ModelAttribute("user") UserVO user) {
		AccountVO vo = new AccountVO();
		vo.setU_id(user.getU_id());
		if(accountDAO.insertAccount(vo)) {
			System.out.println("계정을 생성하였습니다");
		} else {
			System.out.println("계정 생성에 실패하였습니다");
		}
		
		return "redirect:/property";
	}
	
}
