package com.project.mstock;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dao.CommentsDAO;
import vo.CommentsVO;
import vo.UserVO;

@Controller
@SessionAttributes("user")
public class CommentsController {
	@Autowired
	CommentsDAO dao;
	
	@RequestMapping(value="/comment", method=RequestMethod.POST)
	public ModelAndView postcom(CommentsVO vo,RedirectAttributes redirectAttributes
												,String action,int bid,int writer,@ModelAttribute("user") UserVO uvo) {
		ModelAndView mav = new ModelAndView();
		if(uvo.getU_id()==0) {
			mav.addObject("msg", "로그인 후 사용 가능합니다.");
			mav.setViewName("auth/login");
		}else {
			if(action.equals("insert")) {
				dao.insert(vo);
				redirectAttributes.addFlashAttribute("msg", "댓글이 작성되었습니다.");
			}else if(action.equals("update")) {
				dao.update(vo);
				redirectAttributes.addFlashAttribute("msg", "댓글이 수정되었습니다.");
			}
			mav.setViewName("redirect:/board/content?bid="+bid+"&action=read");
		}
		return mav;
	}
	
	@RequestMapping(value="/comment", method=RequestMethod.GET)
	public ModelAndView getcom(CommentsVO vo,RedirectAttributes redirectAttributes
										    ,String action,int cid,int bid) {
		ModelAndView mav = new ModelAndView();
		dao.delete(cid);
		redirectAttributes.addFlashAttribute("msg", "댓글이 삭제되었습니다.");
		mav.setViewName("redirect:/board/content?bid="+bid+"&action=read");
		return mav;
	}
}
