package com.hotels.springboot.social;

import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URISyntaxException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hotels.springboot.jdbc.ImemberDAO;
import com.hotels.springboot.jdbc.MemberDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class NaverController {

	private final NaverService naverService;

	@Autowired
	ImemberDAO memberDao;

	@GetMapping("/naver-login")
	public void naverLogin(HttpServletRequest request, HttpServletResponse response)
			throws MalformedURLException, UnsupportedEncodingException, URISyntaxException {
		try {
			HttpSession session = request.getSession();

			String url = naverService.getNaverAuthorizeUrl("authorize", session);

			response.sendRedirect(url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@GetMapping("/oauth/naver")
	public ResponseEntity<String> NaverCallback(@RequestParam(name = "code") String code,
			@RequestParam(name = "state") String state, HttpSession session,HttpServletResponse response) {
		
		if (!state.equals(session.getAttribute("state"))) {
			return ResponseEntity.status(HttpStatus.FOUND).location(URI.create("/")).build();
		}
		try {
			// 토큰을 가져오기
			String accessToken = naverService.getAccessToken(code);
			// 유저 프로필 가져오기
			NaverUserResponse.NaverUserDetail profile = naverService.getProfile(accessToken);

			MemberDTO member = memberDao.selectNaver(profile.getEmail());

			if (member == null) {
				member = new MemberDTO();
				member.setNaver(profile.getEmail());
				member.setName(profile.getName());
				memberDao.insertNaver(member);
			} 
			session.setAttribute("member", member);
			System.out.println("member:"+member);
			String script = "<script>window.opener.location.reload(); window.close();</script>";
			return ResponseEntity.ok().body(script);

		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.FOUND).location(URI.create("/")).build();
		}
	}

}
