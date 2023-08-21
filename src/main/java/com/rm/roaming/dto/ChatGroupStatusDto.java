package com.rm.roaming.dto;

import java.util.Date;

public class ChatGroupStatusDto {

	private int id;
	private int post_id;
	private int chating_id;
	private int user_id;
	private String status;
	private Date reg_date;
	
	public ChatGroupStatusDto() {
		// TODO Auto-generated constructor stub
	}

	public ChatGroupStatusDto(int id, int post_id, int chating_id, int user_id, String status, Date reg_date) {
		super();
		this.id = id;
		this.post_id = post_id;
		this.chating_id = chating_id;
		this.user_id = user_id;
		this.status = status;
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

	public int getChating_id() {
		return chating_id;
	}

	public void setChating_id(int chating_id) {
		this.chating_id = chating_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	@Override
	public String toString() {
		return "ChatGroupStatusDto [id=" + id + ", post_id=" + post_id + ", chating_id=" + chating_id + ", user_id="
				+ user_id + ", status=" + status + ", reg_date=" + reg_date + "]";
	}

		
	
}
