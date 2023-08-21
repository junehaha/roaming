package com.rm.roaming.dto;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class PartyBoardDto {
	private int id;
	private int post_id;
	private int user_id;
	private String title;
	private String content;
	private int hit;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern = "yyyy.MM.dd HH:mm")
	private Date reg_date;
	
	public PartyBoardDto() {
		// TODO Auto-generated constructor stub
	}

	public PartyBoardDto(int id, int post_id, int user_id, String title, String content, int hit, Date reg_date) {
		super();
		this.id = id;
		this.post_id = post_id;
		this.user_id = user_id;
		this.title = title;
		this.content = content;
		this.hit = hit;
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

	public int getHit() {
		return hit;
	}

	public void setHit(int hit) {
		this.hit = hit;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	@Override
	public String toString() {
		return "PartyBoardDto [id=" + id + ", post_id=" + post_id + ", user_id=" + user_id + ", title=" + title
				+ ", content=" + content + ", hit=" + hit + ", reg_date=" + reg_date + "]";
	}
	
}
