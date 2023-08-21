package com.rm.roaming.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class DayDto {

	private int id;
	private int post_id;
	private int trip_day;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date todayDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date reg_date;
	
	public DayDto() {
		// TODO Auto-generated constructor stub
	}

	public DayDto(int id, int post_id, int trip_day, Date todayDate, Date reg_date) {
		super();
		this.id = id;
		this.post_id = post_id;
		this.trip_day = trip_day;
		this.todayDate = todayDate;
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

	public int getTrip_day() {
		return trip_day;
	}

	public void setTrip_day(int trip_day) {
		this.trip_day = trip_day;
	}

	public Date getTodayDate() {
		return todayDate;
	}

	public void setTodayDate(Date todayDate) {
		this.todayDate = todayDate;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	@Override
	public String toString() {
		return "DayDto [id=" + id + ", post_id=" + post_id + ", trip_day=" + trip_day + ", todayDate=" + todayDate
				+ ", reg_date=" + reg_date + "]";
	}

		
}
