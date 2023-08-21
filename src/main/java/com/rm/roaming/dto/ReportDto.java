package com.rm.roaming.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class ReportDto {
	private int id;
	private int post_id;
	private int user_id;
	private String title;
	private String content;
	private String image;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private Date reg_date;
	
	public ReportDto() {
		// TODO Auto-generated constructor stub
	}

	public ReportDto(int id, int post_id, int user_id, String title, String content, String image, Date reg_date) {
		super();
		this.id = id;
		this.post_id = post_id;
		this.user_id = user_id;
		this.title = title;
		this.content = content;
		this.image = image;
		this.reg_date = reg_date;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getPost_id() {
		return post_id;
	}

	public void setPost_id(int post_id) {
		this.post_id = post_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
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

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	@Override
	public String toString() {
		return "ReportDto [id=" + id + ", post_id=" + post_id + ", user_id=" + user_id + ", title=" + title
				+ ", content=" + content + ", image=" + image + ", reg_date=" + reg_date + "]";
	}

		
	
}
