package com.hotels.springboot.post;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PostService {
	public ArrayList<PostDTO> mainLists(String type, String end);
	
	//목록 : 게시물의 개수를 카운트(커맨드 객체 사용)
	public int getTotalCount(String type);
	
	//목록 : 한페이지에 출력할 게시물을 인출(커맨드 객체 사용)
	public ArrayList<PostDTO> postList(ParameterDTO parameterDTO);
	
	//게시물 상세보기
	public PostDTO postView(PostDTO postDTO);
	
	//게시물 등록 
	public int postWrite(PostDTO postDTO);
	
	//수정(커맨드 객체 사용)
	public int postEdit(PostDTO postDTO);
	
	//삭제
	public int postDelete(String idx);
}
