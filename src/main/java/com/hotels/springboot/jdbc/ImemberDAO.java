package com.hotels.springboot.jdbc;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;



@Mapper
public interface ImemberDAO {

	//회원목록
	public List<MemberDTO> select();
	//이메일 회원등록
	public int insertEmail(MemberDTO memberDTO);
	//Naver 회원등록
	public int insertNaver(MemberDTO memberDTO);
	//이메일 회원조회
	public MemberDTO selectEmail(MemberDTO memberDTO);
	//네이버 회원조회
	public MemberDTO selectNaver(@Param("naver")String naver);
	//IDX 회원조회
	public MemberDTO selectIdx(int idx);
	//회원정보수정
	public int update(MemberDTO memberDTO);
	//회원 프로필 이미지 수정
	public int updateProfile(MemberDTO memberDTO);
	//회원탈퇴(삭제)
	public int delete(MemberDTO memberDTO);
}
