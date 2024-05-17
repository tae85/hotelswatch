package com.hotels.springboot.hotel;

import lombok.Data;

@Data
public class HotelDTO {
	//호텔 테이블
	private int hotel_idx;
	private String hotel;
	private String country;
	private String city;
	private String province;
	private String street;
    private String checkin_time;
    private String checkout_time;
    private String ht_lat;
    private String ht_lng;
    private String picture;
    private String site;
    private double disKm;
    
    //룸 테이블
    private int room_idx;
    private String room;
    private int price;
    private int room_cnt;
    private String room_opic;
    private String room_spic;
    
    //후기 테이블
    private Double grade;
    private String total_comment;
    
    //페이징 관련
    private String start;
    private String end;
}
