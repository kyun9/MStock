package com.project.mstock;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dao.BoardDAO;
import vo.BoardVO;
import dao.CommentsDAO;
import vo.Pagination;
import vo.UserVO;

@Controller
@SessionAttributes("user")
public class BoardController {
	@Autowired
	BoardDAO dao;
	@Autowired
	CommentsDAO cdao;

	@ModelAttribute("user")
	@RequestMapping(value = "/board", method = RequestMethod.GET)
	public ModelAndView doGet(String action,String writer,String key, String searchType,int page) {
		ModelAndView mav = new ModelAndView();
		int listCnt;
		Pagination pagination;
		if (action != null) {
			if (action.equals("search")) { 
				listCnt = dao.boardSearchCnt(key,searchType);
				pagination = new Pagination(listCnt,page);
				mav.addObject("list", dao.search(key, searchType,page));
				mav.addObject("pagination", pagination);
			} else if (action.equals("listwriter")) {
				listCnt = dao.listWriterCnt(writer); 
				pagination = new Pagination(listCnt, page);
				mav.addObject("list", dao.listWriter(writer, page));
				mav.addObject("pagination", pagination);	
			}
		}else {
			listCnt = dao.boardCnt();
			pagination = new Pagination(listCnt, page);
			mav.addObject("list", dao.listAll(page));
			mav.addObject("pagination", pagination);
		}
		mav.setViewName("board/board");
		return mav;
	}

	@ModelAttribute("user")
	@RequestMapping(value = "/board/content", method = RequestMethod.GET)
	public ModelAndView goContent(String action, String bid,@ModelAttribute("user") UserVO uvo
			,RedirectAttributes redirectAttributes) {
		ModelAndView mav = new ModelAndView();
		if (action.equals("read")) {
			mav.addObject("U_Id",uvo.getU_id());
			mav.addObject("listone", dao.listOne(Integer.valueOf(bid)));
			mav.addObject("comlist", cdao.boardcom(Integer.valueOf(bid)));
			mav.setViewName("board/boardContent");
		} else if (action.equals("delete")) {
			mav.setViewName("redirect:/board?page=1");
			dao.delete(Integer.valueOf(bid));
			redirectAttributes.addFlashAttribute("msg", "게시물을 삭제하였습니다.");
		}
		return mav;
	}
	
	@RequestMapping(value = "/board/content/edit", method = RequestMethod.GET)
	public ModelAndView doGetEdit(BoardVO vo,String action,@ModelAttribute("user") UserVO uvo
											 ,HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		if(uvo.getU_id()==0) {
			mav.addObject("msg", "로그인 후 사용 가능합니다.");
			mav.setViewName("auth/login");
		}else {
			if(action.equals("update")) {
				mav.addObject("listone",dao.listOne(Integer.parseInt(req.getParameter("bid"))));
			}
			mav.addObject("U_Id",uvo.getU_id());
			mav.setViewName("board/edit");
		}
		return mav;
	}

	@RequestMapping(value = "/board/content/edit", method = RequestMethod.POST)
	public ModelAndView doPostEdit(BoardVO vo, String action,RedirectAttributes redirectAttributes,
												@ModelAttribute("user") UserVO uvo) {
		ModelAndView mav = new ModelAndView();
		if (action.equals("insert")) {
			mav.setViewName("redirect:/board?page=1");
			dao.insert(vo);
			redirectAttributes.addFlashAttribute("msg", "게시글 작성을 완료했습니다.");
		} else if (action.equals("update")) {
			mav.setViewName("redirect:/board?page=1");
			dao.update(vo);
			redirectAttributes.addFlashAttribute("msg", "게시글 수정을 완료했습니다.");
		}
		return mav;
	}
}
