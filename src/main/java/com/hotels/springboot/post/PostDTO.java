package com.hotels.springboot.post;

import lombok.Data;

@Data
public class PostDTO {
	private int post_idx;
	private String idx;
	private String title;
	private String content;
	private java.sql.Date postdate;
	private String othumb;
	private String sthumb;
	private String ofile;
	private String sfile;
	private String type;
	
}
