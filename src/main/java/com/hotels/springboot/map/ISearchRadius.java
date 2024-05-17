package com.hotels.springboot.map;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.hotels.springboot.hotel.HotelDTO;

@Mapper
public interface ISearchRadius {
	public int searchCount(int distance, double latTxt, double lngTxt);
	
	public ArrayList<HotelDTO> searchRadius(int distance, double latTxt,
			double lngTxt, int start, int end, String searchWord);
}
