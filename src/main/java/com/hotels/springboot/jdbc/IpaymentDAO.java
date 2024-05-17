package com.hotels.springboot.jdbc;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IpaymentDAO {

	//주문저장
	public int insertOrder();
}
