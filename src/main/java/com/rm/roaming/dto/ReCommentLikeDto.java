package com.rm.roaming.dto;

import java.util.Date;

public class ReCommentLikeDto {

	private int id;
	private int recomment_id;
	private int user_id;
	private Date reg_date;
	
	public ReCommentLikeDto() {
		// TODO Auto-generated constructor stub
	}

	public ReCommentLikeDto(int id, int recomment_id, int user_id, Date reg_date) {
		super();
		this.id = id;
		this.recomment_id = recomment_id;
		this.user_id = user_id;
		this.reg_date = reg_date;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getRecomment_id() {
		return recomment_id;
	}

	public void setRecomment_id(int recomment_id) {
		this.recomment_id = recomment_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	@Override
	public String toString() {
		return "ReCommentLikeDto [id=" + id + ", recomment_id=" + recomment_id + ", user_id=" + user_id + ", reg_date="
				+ reg_date + "]";
	}
	
}
