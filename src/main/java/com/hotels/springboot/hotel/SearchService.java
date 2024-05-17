package com.hotels.springboot.hotel;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SearchService {
	//검색 호텔 개수
	public int totalHotel(SearchDTO searchDTO);
	
	//호텔 리스트 ajax
	public ArrayList<HotelDTO> hotelList(SearchDTO searchDTO);
	
	//호텔 검색
	public ArrayList<HotelDTO> searchHotel(SearchDTO searchDTO);
	
	//검색어 저장
	public int updateKeyword(String search_keyword, String idx);
	
	//호텔 상세보기 - 호텔정보
	public HotelDTO viewHotel(int hotel_idx);
	
	//호텔 상세보기 - grade 구하기
	public Double hotelGrade(int hotel_idx);
	
	//호텔 상세보기 - 객실정보
	public ArrayList<HotelDTO> viewRoom(HotelDTO hotelDTO);
	
	//객실 보기 - 호텔 idx로
	public ArrayList<HotelDTO> selectHotel(int hotel_idx);
	
	//객실 보기 - 객실 idx로
	public HotelDTO selectRoom(int room_idx);
	
	//객실 전체 리스트(필요없을듯)
	public ArrayList<HotelDTO> roomList(SearchDTO searchDTO);
	
}
