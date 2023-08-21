package com.rm.roaming.dto;

import java.util.Date;

public class UnionDto {
	
	private int id;
	private int user_id;
	private int reels_id;
	private int feed_id;
	private String title;
	private String content;
	private String image;
	private String video;
	private String type;
	private String reg_date;

	public UnionDto() {
		super();
	}
	
	public UnionDto(int id, int user_id, int reels_id, int feed_id, String title, String content, String image,
			String video, String type, String reg_date) {
		super();
		this.id = id;
		this.user_id = user_id;
		this.reels_id = reels_id;
		this.feed_id = feed_id;
		this.title = title;
		this.content = content;
		this.image = image;
		this.video = video;
		this.type = type;
		this.reg_date = reg_date;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getReels_id() {
		return reels_id;
	}
	public void setReels_id(int reels_id) {
		this.reels_id = reels_id;
	}
	public int getFeed_id() {
		return feed_id;
	}
	public void setFeed_id(int feed_id) {
		this.feed_id = feed_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getVideo() {
		return video;
	}
	public void setVideo(String video) {
		this.video = video;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
		
}
