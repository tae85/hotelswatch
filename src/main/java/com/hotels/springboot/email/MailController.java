package com.hotels.springboot.email;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hotels.springboot.jdbc.CertEmailDTO;
import com.hotels.springboot.jdbc.IcertEmailDAO;
import com.hotels.springboot.jdbc.ImemberDAO;
import com.hotels.springboot.jdbc.MemberDTO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MailController {

	@Autowired
	IcertEmailDAO emailDao;

	@Autowired
	ImemberDAO memberDao;

	private final MailService mailService;

	// 인증메일 보내기
	@PostMapping("/emailSend.do")
	public ResponseEntity<?> MailSend(@RequestParam("mail") String mail) {

		// 만료된 이메일 전부 삭제
		emailDao.deleteExpiredEmails();

		int number = mailService.sendMail(mail);
		LocalDateTime expiryTime = LocalDateTime.now().plusMinutes(1);

		CertEmailDTO dto = new CertEmailDTO();

		dto.setEmail(mail);
		dto.setCert_num(number);
		dto.setExpiry_time(expiryTime);

		try {
			emailDao.write(dto);
		} catch (Exception e) {
			// 이미 DB에 같은 이메일로 보낸 인증번호가 있는경우 지우고 재발송
			emailDao.delete(mail);
			emailDao.write(dto);
		}
		return ResponseEntity.ok().body("{\"message\":\"이메일 정상적으로 발송되었습니다.\"}");

	}

	// 이메일 인증 확인
	@PostMapping("/confirmEmail.do")
	public ResponseEntity<?> confirmEmail(HttpSession session, Model model, @RequestParam("email") String mail,
			@RequestParam("certNum") int certNum) {

		CertEmailDTO dto = emailDao.view(new CertEmailDTO(mail));

		// 인증성공시
		if (dto != null && dto.getCert_num() == certNum && LocalDateTime.now().isBefore(dto.getExpiry_time())) {

			// 검증된 이메일 삭제
			emailDao.delete(mail);

			MemberDTO member = memberDao.selectEmail(new MemberDTO(mail));

			if (member == null) {
				member = new MemberDTO(mail);
				memberDao.insertEmail(member);
				member = memberDao.selectEmail(new MemberDTO(mail));
			}
			session.setAttribute("member", member);
			System.out.println("member:" + member);
			return ResponseEntity.ok("{\"message\":\"인증 성공\"}");
			// 인증번호가 틀린경우
		} else if (dto != null && dto.getCert_num() != certNum) {
			return ResponseEntity.badRequest()
					.contentType(MediaType.APPLICATION_JSON)
					.body("{\"message\":\"인증번호가 틀렸습니다.\"}");

		}
		// 인증번호가 삭제되어 없거나 발송이 안된경우
		return ResponseEntity.status(404)
				.contentType(MediaType.APPLICATION_JSON)
				.body("{\"message\":\"인증 정보가 유효하지 않거나 만료되었습니다.\"}");
	}

}
