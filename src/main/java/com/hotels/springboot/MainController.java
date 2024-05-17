package com.hotels.springboot;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hotels.springboot.post.ParameterDTO;
import com.hotels.springboot.post.PostDTO;
import com.hotels.springboot.post.PostService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class MainController {
	@Autowired
	PostService dao;
	@Value("#{myprops['my.eventMain']}")
	private String eventMain;
	@Value("#{myprops['my.noticeMain']}")
	private String noticeMain;
	
	@RequestMapping("/")
	public String home(Model model, HttpServletRequest req, ParameterDTO parameterDTO) {

		ArrayList<PostDTO> eventLists = dao.mainLists("e", eventMain);
		model.addAttribute("eventLists", eventLists);
		
		ArrayList<PostDTO> noticeLists = dao.mainLists("n", noticeMain);
		model.addAttribute("noticeLists", noticeLists);
		
		return "index";
	}
	
	@RequestMapping("/restComments.do")
	public String restComments() {
		return "/rest/restComments";
	}

	@RequestMapping("/mypage.do")
	public String mypage() {
		return "/member/mypage";
	}
	
	@RequestMapping("/admin.do")
	public String admin() {
		return "/member/admin";
	}
	
	@RequestMapping("/memberDetail.do")
	public String member_detail() {
		return "/member/member_detail";
	}
	

	

	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "index";
	}

}
