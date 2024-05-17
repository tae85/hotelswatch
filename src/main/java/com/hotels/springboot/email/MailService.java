package com.hotels.springboot.email;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MailService {

	private final JavaMailSender javaMailSender;

	@Value("${spring.mail.username}")
	private String from;
	
	private static int number;

	
	
	public static void createNumber() {
		number = (int) (Math.random() * (90000)) + 100000;
		
	}

	public MimeMessage CreateMail(String mail) {

		createNumber();
		
		MimeMessage message = javaMailSender.createMimeMessage();

		try {
			message.setFrom(from);
			message.setRecipients(MimeMessage.RecipientType.TO, mail);
			message.setSubject("이메일 인증");
			String body = "";
			body += "<h3>" + "6자리 인증 코드를 복사하여" 
			+ " 아래 호텔스와치 로그인 페이지에 붙여넣기하세요." + "</h3>";
			body += "<h1>" + number + "</h1>";
			body += "<h3>" + "이 인증 코드는 10분 후에 만료됩니다. "
			+ "그때까지 인증을 완료하지 못하셨을 경우, 호텔스와치에서"
			+ " 새로운 코드를 요청하세요." + "</h3>";
			message.setText(body, "UTF-8", "html");

		} catch (MessagingException e) {
			e.printStackTrace();
		}
		return message;
	}

	public int sendMail(String mail) {

		MimeMessage message = CreateMail(mail);
		
		try {
			javaMailSender.send(message);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return number;
	}
	

}
