package com.hotels.springboot.comments;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hotels.springboot.jdbc.MemberDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@RestController
public class CommentsRestController {
	@Autowired
	CommentsRestService crs;
	
	@GetMapping("/restIdx.do")
	public Map<String, String> restIdx(HttpServletRequest req) {
		HttpSession session = req.getSession();
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		Map<String, String> result = new HashMap<>();
		CommentsDTO getEmail = new CommentsDTO();
		if(member == null) {
			result.put("idx_rest", "");
			getEmail.setEmail("");
			getEmail.setNaver("");
			getEmail.setGoogle("");
			getEmail.setApple("");
		}
		else {
			String idx_rest = member.getIdx();
			getEmail = crs.getEmail(idx_rest);
			result.put("idx_rest", idx_rest);
		}
		
		String hotel_idx_rest = (String) session.getAttribute("hotel_idx_rest");
		String commentsCount = (crs.commentsCount(Integer.parseInt(hotel_idx_rest)));
		
		String emailTemp;
		if(getEmail.getEmail() != null) {
			System.out.println(getEmail.getEmail());
			emailTemp = getEmail.getEmail();
		}
		else if(getEmail.getNaver() != null) {
			emailTemp = getEmail.getNaver();
		}
		else if(getEmail.getGoogle() != null) {
			emailTemp = getEmail.getGoogle();
		}
		else if(getEmail.getApple() != null) {
			emailTemp = getEmail.getApple();
		}
		else {
			emailTemp ="";
		}
		
		result.put("hotel_idx_rest", hotel_idx_rest);
		result.put("commentsCount", commentsCount);
		result.put("emailTemp", emailTemp);
		
		return result;
	}
	
	@GetMapping("/restCommentsList.do")
	public List<CommentsDTO> restCommentsList(@RequestParam("hotel_idx") int hotel_idx) {
		List<CommentsDTO> commentsList = crs.commentsList(hotel_idx);
		
		return commentsList;
	}
	
	@PostMapping("/restCommentsWrite.do")
	public Map<String, Integer> restCommentsWrite(CommentsDTO commentsDTO) {
		int result = crs.commentsWrite(commentsDTO);
		
		Map<String, Integer> map = new HashMap<>();
		map.put("result", result);
		
		return map;
	}
	
	@PostMapping("/restCommentsEdit.do")
	public Map<String, Integer> restCommentsEdit(CommentsDTO commentsDTO) {
		System.out.println("commentsDTO=" + commentsDTO);
		int result = crs.commentsEdit(commentsDTO);
		
		Map<String, Integer> map = new HashMap<>();
		map.put("result", result);
		
		return map;
	}
	
	@PostMapping("/restCommentsDelete.do")
	public Map<String, Integer> restCommentsDelete(@RequestParam("comment_idx") int comment_idx) {
		System.out.println("restCommentsDelete=" + comment_idx);
		int result = crs.commentsDelete(comment_idx);
		
		Map<String, Integer> map = new HashMap<>();
		map.put("result", result);
		
		return map;
	}
}
