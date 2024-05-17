package com.hotels.springboot.jdbc;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface IcertEmailDAO {

	public int write(CertEmailDTO certEmailDTO);

	public CertEmailDTO view(CertEmailDTO certEmailDTO);
	
	public int delete(String email);
	
	public int deleteExpiredEmails();
	
	
}
