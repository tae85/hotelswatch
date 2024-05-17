package com.hotels.springboot.jdbc;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberDTO {
	
	private String idx;
	private String email;
	private String google;
	private String naver;
	private String apple;
	private String name;
	private String nickname;
	private String profile;
	private String search_keyword;
	private String signup_date;
	private String admin;
	

	public MemberDTO(String email) {
		this.email = email;
	}
	
}
