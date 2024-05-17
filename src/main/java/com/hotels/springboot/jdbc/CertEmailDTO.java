package com.hotels.springboot.jdbc;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class CertEmailDTO {

	private String email;
	private int cert_num;
	private LocalDateTime expiry_time;
	
	
	public CertEmailDTO (String mail) {
		this.email= mail;
	}
}
