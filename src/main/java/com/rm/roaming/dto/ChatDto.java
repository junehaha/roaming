package com.rm.roaming.dto;

import java.util.Date;

public class ChatDto {
	private int id;
	private int chat_id;
	private int user_id;
	private String chating;
	private int read_count;
	private Date reg_date;
	
	public ChatDto() {
		// TODO Auto-generated constructor stub
	}

	public ChatDto(int id, int chat_id, int user_id, String chating, int read_count, Date reg_date) {
		super();
		this.id = id;
		this.chat_id = chat_id;
		this.user_id = user_id;
		this.chating = chating;
		this.read_count = read_count;
		this.reg_date = reg_date;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getChat_id() {
		return chat_id;
	}

	public void setChat_id(int chat_id) {
		this.chat_id = chat_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getChating() {
		return chating;
	}

	public void setChating(String chating) {
		this.chating = chating;
	}

	public int getRead_count() {
		return read_count;
	}

	public void setRead_count(int read_count) {
		this.read_count = read_count;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	@Override
	public String toString() {
		return "ChatDto [id=" + id + ", chat_id=" + chat_id + ", user_id=" + user_id + ", chating=" + chating
				+ ", read_count=" + read_count + ", reg_date=" + reg_date + "]";
	}
		
}
