package com.hotels.springboot.hotel;

import lombok.Data;

@Data
public class SearchDTO {
	private String searchWord;
	private String checkin;
	private String checkout;
	private String room_cnt;
	private String minPrice;
	private String maxPrice;
	private String grade;
	private Double ht_lat;
	private Double ht_lng;
	private int start;
	private int end;
	
	private int hotel_idx;
	private int room_idx;
}
