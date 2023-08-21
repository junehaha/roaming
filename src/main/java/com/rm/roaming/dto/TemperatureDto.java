package com.rm.roaming.dto;

import java.util.Date;

public class TemperatureDto {

	private int id;
	private int user_id;
	private double score;
	private Date reg_date;
	
	public TemperatureDto() {
		// TODO Auto-generated constructor stub
	}

	public TemperatureDto(int id, int user_id, double score, Date reg_date) {
		super();
		this.id = id;
		this.user_id = user_id;
		this.score = score;
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

	public double getScore() {
		return score;
	}

	public void setScore(double score) {
		this.score = score;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	@Override
	public String toString() {
		return "TemperatureDto [id=" + id + ", user_id=" + user_id + ", score=" + score + ", reg_date=" + reg_date
				+ "]";
	}

		
}
