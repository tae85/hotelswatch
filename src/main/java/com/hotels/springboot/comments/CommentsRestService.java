package com.hotels.springboot.comments;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommentsRestService {
	//이메일 가져오기
	public CommentsDTO getEmail(String idx);
	
	//후기 카운트
	public String commentsCount(int hotel_idx);
	
	//후기 리스트
	public ArrayList<CommentsDTO> commentsList(int hotel_idx);
	
	//후기 작성
	public int commentsWrite(CommentsDTO commentsDTO);
	
	//후기 수정
	public int commentsEdit(CommentsDTO commentsDTO);
	
	//후기 삭제
	public int commentsDelete(int hotel_idx);
}
