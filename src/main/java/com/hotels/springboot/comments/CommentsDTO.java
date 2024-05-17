package com.hotels.springboot.comments;

import lombok.Data;

@Data
public class CommentsDTO {
	private int comment_idx;
	private String idx;
	private int hotel_idx;
	private Double grade;
	private String comments;
	private String comment_date;

	private String email;
	private String apple;
	private String naver;
	private String google;
	private String site;
}
