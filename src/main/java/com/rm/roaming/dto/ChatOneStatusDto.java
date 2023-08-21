package com.rm.roaming.dto;

import java.util.Date;

public class ChatOneStatusDto {
	private int id;
	private int chating_id;
	private int user_id;
	private String status;
	private Date reg_date;
	
	public ChatOneStatusDto() {
		// TODO Auto-generated constructor stub
	}

	
	public ChatOneStatusDto(int id, int chating_id, int user_id, String status, Date reg_date) {
		super();
		this.id = id;
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
		return "ChatOneStatus [id=" + id + ", chating_id=" + chating_id + ", user_id=" + user_id + ", status=" + status
				+ ", reg_date=" + reg_date + "]";
	}
	
	
}
