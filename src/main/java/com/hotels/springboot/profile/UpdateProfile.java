package com.hotels.springboot.profile;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.PostMapping;

import com.hotels.springboot.jdbc.ImemberDAO;
import com.hotels.springboot.jdbc.MemberDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import utils.MyFunctions;

@Controller
public class UpdateProfile {

	@Autowired
	ImemberDAO dao;

	// 싱글파일 업로드 처리
	@PostMapping("/uploadProfile")
	public ResponseEntity<?> uploadProcess(HttpServletRequest req) {

		HttpSession session = req.getSession();
		MemberDTO member = (MemberDTO) session.getAttribute("member");


		try {
			// 업로드 디렉토리의 물리적경로를 얻어온다.
			String uploadDir = ResourceUtils.getFile("classpath:static/uploads/").toPath().toString();

			// 전송된 첨부파일을 Part 객체를 통해 얻어온다.
			Part part = req.getPart("uploadFile");
			// 파일명 확인을 위해 헤더값을 얻어온다.
			String partHeader = part.getHeader("content-disposition");
			System.out.println("partHeader=" + partHeader);
			// 헤더값에서 파일명을 추출하기 위해 문자열을 split()한다.
			String[] phArr = partHeader.split("filename=");
			// 따옴표를 제거한 후 원본파일명을 추출한다.
			String originalFileName = phArr[1].trim().replace("\"", "");
			System.out.println("originalFileName:" + originalFileName);
			// 전송된 파일이 있다면 서버에 저장한다.
			if (!originalFileName.isEmpty()) {
				part.write(uploadDir + File.separator + originalFileName);
			}

			// 서버에 저장된 파일명을 중복되지 않는 이름으로 변경한다.
			String savedFileName = MyFunctions.renameFile(uploadDir, originalFileName);
			member.setProfile(savedFileName);
			System.out.println("member:" + member);

			int result = dao.updateProfile(member);
			if (result == 1) {
				System.out.println("수정되었습니다.");
				return ResponseEntity.ok("파일 업로드 성공");
			} else {
				System.out.println("수정 실패: 업데이트된 행이 없습니다.");
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Profile update failed");
			}

		} catch (Exception e) {
			System.out.println("업로드 실패: " + e.getMessage());
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Upload failed: " + e.getMessage());
		}
	}

	@PostMapping("/updateProfile")
	public String updateProfie(HttpServletRequest request) {
		
		String name = request.getParameter("name");
		String nickname = request.getParameter("nickname");
		String email = request.getParameter("email");
		String naver = request.getParameter("naver");
		

		HttpSession session = request.getSession();
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		member.setName(name);
		member.setNickname(nickname);
		member.setEmail(email);
		member.setNaver(naver);

		System.out.println("member:"+ member);
		
		try {
			int updateResult = dao.update(member);
			if (updateResult == 1) {
				System.out.println("업데이트 완료");
			} else {
				System.out.println("업데이트 실패");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "/member/mypage";
	}

}
